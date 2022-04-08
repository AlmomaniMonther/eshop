import 'dart:io';

import 'package:flutter/material.dart';

class ChosenCategoryImage extends StatelessWidget {
  const ChosenCategoryImage({
    Key? key,
    required File? storedImage,
  })  : _storedImage = storedImage,
        super(key: key);

  final File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 236, 187, 37),
          Color.fromARGB(255, 214, 55, 41)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: FileImage(
              _storedImage!,
            ),
            fit: BoxFit.contain),
      ),
    );
  }
}
