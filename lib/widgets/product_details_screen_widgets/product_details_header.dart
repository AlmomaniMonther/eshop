import 'package:flutter/material.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        const Text(
          'Product Details',
          style: TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
