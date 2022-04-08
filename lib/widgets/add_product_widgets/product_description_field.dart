import 'package:flutter/material.dart';

typedef StringCallback = void Function(String productDescription);

class ProductDescriptionField extends StatelessWidget {
  const ProductDescriptionField({
    Key? key,
    required this.productDescriptionCallback,
  }) : super(key: key);
  final StringCallback productDescriptionCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: 'Description',
        hintStyle: TextStyle(color: Colors.grey),
        hintText: 'Add Product Description',
      ),
      onChanged: (value) {
        productDescriptionCallback(value);
      },
    );
  }
}
