import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white70,
          ),
          onPressed: () {
            _launchURL('https://facebook.com/monther.almomani/');
          },
          child: Image.asset(
            'assets/logos/facebook_logo.png',
            width: 75,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.white70),
          onPressed: () {
            _launchURL('https://twitter.com/eng_abo_habib');
          },
          child: Image.asset(
            'assets/logos/twitter_logo.png',
            width: 75,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.white70),
          onPressed: () {
            _launchURL('https://instagram.com/eng.abo.habib');
          },
          child: Image.asset(
            'assets/logos/instagram_logo.png',
            width: 75,
          ),
        ),
      ],
    );
  }
}
