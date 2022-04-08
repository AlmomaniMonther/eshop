import 'package:flutter/material.dart';

import '../../helpers/products_helper.dart';

class RemoveProductButton extends StatelessWidget {
  const RemoveProductButton({
    Key? key,
    required this.categoryName,
    required this.productName,
    required this.quantity,
  }) : super(key: key);

  final String categoryName;
  final String productName;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: quantity > 1
            ? const Icon(Icons.remove, size: 20)
            : const Icon(Icons.delete, size: 20),
        onPressed: () async {
          await ProductsHelper.removeProduct(
              productName, quantity, categoryName);
        });
  }
}
