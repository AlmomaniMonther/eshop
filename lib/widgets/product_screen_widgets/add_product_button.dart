import 'package:flutter/material.dart';

import '../../screens/add_product.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProduct(categoryName)));
        },
        icon: const Icon(Icons.add));
  }
}
