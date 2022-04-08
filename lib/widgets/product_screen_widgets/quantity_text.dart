import 'package:flutter/material.dart';

class QuantityText extends StatelessWidget {
  const QuantityText({
    Key? key,
    required this.quantity,
  }) : super(key: key);
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Text(
      quantity != 0 ? '${quantity.toString()} pcs' : 'Out of stock',
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
