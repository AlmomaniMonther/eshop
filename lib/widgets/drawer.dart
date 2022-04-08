import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';
import '../screens/user_orders.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
      {Key? key,
      required this.isAdmin,
      required this.userName,
      required CartProvider cart,
      required this.userId})
      : super(key: key);
  final bool? isAdmin;
  final String? userName;

  final String userId;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(255, 75, 59, 1),
              Color.fromARGB(255, 255, 166, 0),
              Color.fromRGBO(255, 193, 7, 0.7),
              Color.fromRGBO(255, 75, 59, 1)
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, kToolbarHeight / 5, 8, 0),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                    child: Image.asset(
                  'assets/logo.png',
                )),
                const Text(
                  'SHOP',
                  style: TextStyle(
                      fontSize: 100,
                      fontFamily: 'Anton',
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
            if (!isAdmin!)
              ListTile(
                leading:
                    const Icon(Icons.person, size: 30, color: Colors.black87),
                title: const Text(
                  'My Account',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/userAccount');
                },
              ),
            isAdmin!
                ? ListTile(
                    leading: const Icon(Icons.subject_rounded,
                        size: 30, color: Colors.black87),
                    title: const Text(
                      'Users Orders',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/usersScreen');
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.subject_rounded,
                        size: 30, color: Colors.black87),
                    title: const Text(
                      'My Orders',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UserOrders(userId: userId, userName: userName!)));
                    },
                  ),
            ListTile(
              leading: const Icon(Icons.info, size: 30, color: Colors.black87),
              title: const Text(
                'About us...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/aboutUsScreen');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.feedback, size: 30, color: Colors.black87),
              title: const Text(
                'Feedback...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/feedbackScreen');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.logout, size: 30, color: Colors.black87),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
