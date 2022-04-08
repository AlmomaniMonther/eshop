import 'package:flutter/material.dart';

import '../../providers/cart_provider.dart';
import 'make_order_button.dart';

class CartScreenHeader extends StatelessWidget {
  const CartScreenHeader({
    Key? key,
    required CartProvider cart,
  })  : _cart = cart,
        super(key: key);

  final CartProvider _cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        const Text(
          'Cart details',
          style: TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
        const Expanded(child: SizedBox()),
        MakeOrderButton(cart: _cart),
      ],
    );
  }
}
