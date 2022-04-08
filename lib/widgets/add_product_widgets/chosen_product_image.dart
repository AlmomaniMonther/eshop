import 'dart:io';

import 'package:flutter/material.dart';

class ChosenProductImage extends StatelessWidget {
  const ChosenProductImage({
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 193, 7, 0.7),
            Color.fromARGB(255, 248, 39, 20)
          ],
        ),
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
