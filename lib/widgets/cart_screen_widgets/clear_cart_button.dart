import 'package:flutter/material.dart';

import '../../providers/cart_provider.dart';

class ClearCartButton extends StatelessWidget {
  const ClearCartButton({
    Key? key,
    required CartProvider cart,
  })  : _cart = cart,
        super(key: key);

  final CartProvider _cart;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          _cart.clearCartList();
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
        label: const Text(
          'Clear Cart',
          style: TextStyle(
            color: Colors.black,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 8.0,
                color: Color.fromARGB(123, 104, 104, 104),
              ),
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 8.0,
                color: Color.fromARGB(123, 104, 104, 104),
              ),
            ],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
