import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers/cart_provider.dart';
import '../../helpers/orders_helper.dart';

class MakeOrderButton extends StatelessWidget {
  const MakeOrderButton({
    Key? key,
    required CartProvider cart,
  })  : _cart = cart,
        super(key: key);

  final CartProvider _cart;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (_cart.cartList.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Your cart is empty!',
            backgroundColor: Colors.red.shade800,
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM,
          );
          return;
        } else {
          Order.makeOrder(
            _cart.cartList.values.toList(),
            _cart.totalOrderPrice(),
          );
          _cart.clearCartList();
        }
      },
      icon: const Icon(Icons.send_rounded),
      tooltip: 'Send Order',
    );
  }
}
