import 'package:flutter/material.dart';

typedef StringCallback = void Function(String productTitle);

class ProductTitleField extends StatelessWidget {
  const ProductTitleField({
    Key? key,
    required this.productTitleCallback,
  }) : super(key: key);
  final StringCallback productTitleCallback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        labelText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
        hintText: 'Add Product title',
      ),
      onChanged: (value) {
        productTitleCallback(value);
      },
    );
  }
}
