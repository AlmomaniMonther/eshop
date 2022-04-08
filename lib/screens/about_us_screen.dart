import 'package:flutter/material.dart';
import '../widgets/about_us_screen_widgets/about_me_text.dart';
import '../widgets/about_us_screen_widgets/developer_image.dart';
import '../widgets/about_us_screen_widgets/social_media.dart';
import '../widgets/about_us_screen_widgets/support_me.dart';

//* This Screen is a screen that shows some data about the developer */
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 236, 179),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 26),
        title: const Text(
          'About Me...',
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Anton',
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DeveloperImage(),
            SizedBox(
              height: kToolbarHeight / 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'About me:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            AboutMeText(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Contact me:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SocialMedia(),
            SupportMe(),
          ],
        ),
      ),
    );
  }
}
