import 'package:flutter/material.dart';

typedef DoubleCallback = void Function(double productPrice);

class ProductPriceField extends StatelessWidget {
  const ProductPriceField({
    Key? key,
    required this.productPriceCallback,
  }) : super(key: key);
  final DoubleCallback productPriceCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: 'Price',
        hintStyle: TextStyle(color: Colors.grey),
        hintText: 'Add Product Price',
      ),
      onChanged: (value) {
        productPriceCallback(double.parse(value));
      },
    );
  }
}
