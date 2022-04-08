import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../models/product_model.dart';

class AddProductToCartButton extends StatelessWidget {
  const AddProductToCartButton({
    Key? key,
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.title,
    required this.category,
  }) : super(key: key);
  final String id;
  final String category;
  final String description;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          final cart = Provider.of<CartProvider>(context, listen: false);

          cart.addProductToCart(
              Product(
                  id: id,
                  description: description,
                  title: title,
                  category: category,
                  quantity: quantity,
                  image: imageUrl,
                  price: price,
                  orderedQuantity: 1),
              quantity);
        },
        icon: const Icon(Icons.add_shopping_cart));
  }
}
