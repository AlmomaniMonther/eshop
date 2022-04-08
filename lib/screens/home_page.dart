import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/providers/cart_provider.dart';
import 'package:eshop/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import '../widgets/home_widgets/categories_widgets.dart';
import '../widgets/home_widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isAdmin;

  String? userName;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final userId = FirebaseAuth.instance.currentUser!.uid;
//** Here the app get's the user data to render the widgets
//* depends on the current logged in user
//* if the user was admin or client */

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.data!.exists) {
            return const LoadingScreen();
          }

          return Scaffold(
            key: _scaffoldKey,
            drawer: AppDrawer(
                isAdmin: snapshot.data!['isAdmin'],
                userName: snapshot.data!['username'],
                cart: _cart,
                userId: userId),
            backgroundColor: Colors.amber.shade50,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromRGBO(255, 193, 7, 0.7),
                    Color.fromRGBO(255, 75, 59, 1)
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: kToolbarHeight / 2,
                  ),
                  HomeHeader(
                      isAdmin: snapshot.data!['isAdmin'],
                      userName: snapshot.data!['username'],
                      scaffoldState: _scaffoldKey,
                      cart: _cart,
                      userId: userId),
                  CategoriesWidget(isAdmin: snapshot.data!['isAdmin']),
                ],
              ),
            ),
          );
        });
  }
}
