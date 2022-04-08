import 'package:flutter/material.dart';

class ProductNameText extends StatelessWidget {
  const ProductNameText({
    Key? key,
    required this.productName,
  }) : super(key: key);
  final String productName;
  @override
  Widget build(BuildContext context) {
    return Text(
      productName,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
