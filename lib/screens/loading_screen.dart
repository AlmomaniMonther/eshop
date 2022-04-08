import 'package:flutter/material.dart';

//** This is the loading screen */
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Loading...',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Anton', fontWeight: FontWeight.w500),
          ),
          LinearProgressIndicator(),
        ],
      ),
    ));
  }
}
