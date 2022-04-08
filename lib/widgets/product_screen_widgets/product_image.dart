import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.productImageUrl,
  }) : super(key: key);
  final String productImageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            productImageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
