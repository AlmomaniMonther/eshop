import 'package:flutter/material.dart';

class AboutMeText extends StatelessWidget {
  const AboutMeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(14),
      child: Text(
        'Hello everybody! \nMy name is Monther Almomani,'
        ' a communication engineer student in the last year.'
        ' \nI started to learn mobile app development about seven months'
        ' ago, and this is one of my first applications totally developed by me.'
        ' \nHope you enjoy your time using it and send me feedback about'
        ' your experience and what you hope to be better in the future.'
        '\nThank you for your support.',
        style: TextStyle(
            fontSize: 17,
            overflow: TextOverflow.visible,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
