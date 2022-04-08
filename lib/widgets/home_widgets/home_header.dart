import 'package:flutter/material.dart';

import '../../screens/add_category.dart';
import '../../screens/cart_screen.dart';
import '../../providers/cart_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {Key? key,
      required this.isAdmin,
      required this.userName,
      required CartProvider cart,
      required this.scaffoldState,
      required this.userId})
      : _cart = cart,
        super(key: key);

  final bool? isAdmin;
  final String? userName;
  final CartProvider _cart;
  final String userId;
  final GlobalKey<ScaffoldState> scaffoldState;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                scaffoldState.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
          TitleText(isAdmin: isAdmin, userName: userName),
          isAdmin! ? const AddCategoryButton() : CartButton(cart: _cart),
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.isAdmin,
    required this.userName,
  }) : super(key: key);

  final bool? isAdmin;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Text(
      isAdmin! ? 'Admin Panel' : 'WELCOME $userName',
      style: const TextStyle(
          fontSize: 24, fontFamily: 'Anton', fontWeight: FontWeight.w500),
    );
  }
}

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddCategory()));
        },
        icon: const Icon(Icons.add));
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
    required CartProvider cart,
  })  : _cart = cart,
        super(key: key);

  final CartProvider _cart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()));
          },
          icon: const Icon(
            Icons.shopping_cart,
            size: 30,
          ),
        ),
        Positioned(
          right: 6,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 252, 151, 0)),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              _cart.totalOrderQuantity().toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
