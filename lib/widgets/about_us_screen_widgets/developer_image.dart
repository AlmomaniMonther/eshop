import 'package:flutter/material.dart';

class DeveloperImage extends StatelessWidget {
  const DeveloperImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.zero,
      child: Image.asset(
        'assets/developer.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
