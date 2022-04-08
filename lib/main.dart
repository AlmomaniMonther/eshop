import 'package:eshop/screens/auth_screen.dart';
import 'package:eshop/providers/cart_provider.dart';
import 'package:eshop/screens/loading_screen.dart';
import 'package:eshop/screens/user_account.dart';
import 'package:eshop/screens/users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/about_us_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/home_page.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CartProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eShop',
        theme: ThemeData(
          // This is the theme of the application.

          primarySwatch: Colors.red,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              }
              if (userSnapshot.hasData) {
                return const HomePage();
              }
              return const AuthScreen();
            }),
        routes: {
          '/feedbackScreen': (context) => const FeedbackScreen(),
          '/aboutUsScreen': (context) => const AboutUsScreen(),
          '/usersScreen': (context) => const UsersScreen(),
          '/userAccount': (context) => UserAccount(),
        },
      ),
    );
  }
}
