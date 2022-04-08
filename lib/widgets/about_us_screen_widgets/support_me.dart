import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportMe extends StatelessWidget {
  const SupportMe({
    Key? key,
  }) : super(key: key);
  //* This method is called to launch urls/
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Support me on PayPal:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                primary: Colors.white70),
            onPressed: () {
              _launchURL('https://paypal.me/abohabib98');
            },
            child: Image.asset(
              'assets/logos/paypal_logo.png',
              width: 75,
            ),
          ),
        ],
      ),
    );
  }
}
