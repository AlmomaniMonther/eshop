import 'package:eshop/screens/product_details_screen.dart';
import 'package:eshop/providers/cart_provider.dart';
import 'package:eshop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_screen_widgets/cart_screen_header.dart';
import '../widgets/cart_screen_widgets/clear_cart_button.dart';
import '../widgets/cart_screen_widgets/empty_cart.dart';
import '../widgets/cart_screen_widgets/total_amount_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Container(
        // Screen background
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 193, 7, 0.7),
              Color.fromRGBO(255, 75, 59, 1)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: kToolbarHeight / 2,
            ),
            CartScreenHeader(cart: _cart),
            const SizedBox(
              height: kToolbarHeight / 2,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClearCartButton(cart: _cart),
                        TotalAmountText(cart: _cart),
                      ],
                    ),
                    Expanded(
                      child: _cart.cartList.isEmpty
                          ? const EmptyCart()
                          : ListView.builder(
                              itemCount: _cart.itemCount,
                              itemBuilder: (context, index) => Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                child: ListTile(
                                    title: Text(
                                      _cart.cartList.values
                                          .toList()[index]
                                          .title,
                                    ),
                                    subtitle: Text(
                                        '${_cart.totalPrice(_cart.cartList.values.toList()[index].id).toString()}\$'),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        _cart.cartList.values
                                            .toList()[index]
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _cart.addSingleProduct(_cart
                                                  .cartList.values
                                                  .toList()[index]
                                                  .id);
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_outline)),
                                        Text(_cart.cartList.values
                                                .toList()[index]
                                                .orderedQuantity
                                                .toString() +
                                            ' pcs'),
                                        IconButton(
                                            onPressed: () {
                                              _cart.removeSingleProduct(_cart
                                                  .cartList.values
                                                  .toList()[index]
                                                  .id);
                                            },
                                            icon: const Icon(
                                                Icons.remove_circle_outline))
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ProductDetailsScreen(
                                              product: Product(
                                                  id: _cart.cartList.values
                                                      .toList()[index]
                                                      .id,
                                                  title: _cart.cartList.values
                                                      .toList()[index]
                                                      .title,
                                                  description: _cart
                                                      .cartList.values
                                                      .toList()[index]
                                                      .description,
                                                  price: _cart.cartList.values
                                                      .toList()[index]
                                                      .price,
                                                  image: _cart.cartList.values
                                                      .toList()[index]
                                                      .image,
                                                  category: _cart
                                                      .cartList.values
                                                      .toList()[index]
                                                      .category,
                                                  quantity: _cart
                                                      .cartList.values
                                                      .toList()[index]
                                                      .quantity))));
                                    }),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
