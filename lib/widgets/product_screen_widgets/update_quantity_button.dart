import 'package:flutter/material.dart';

import '../../helpers/products_helper.dart';

class UpdateQuantityButton extends StatelessWidget {
  const UpdateQuantityButton({
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
        icon: const Icon(Icons.add, size: 20),
        onPressed: () async {
          await ProductsHelper.updateQuantity(
              productName, quantity, categoryName);
        });
  }
}
