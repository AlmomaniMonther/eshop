import 'package:eshop/models/product_model.dart';
import 'package:flutter/material.dart';

import '../widgets/product_details_screen_widgets/detailed_product_image.dart';
import '../widgets/product_details_screen_widgets/product_details_header.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.product, Key? key})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(255, 193, 7, 0.7),
              Color.fromRGBO(255, 75, 59, 1)
            ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight / 2,
              ),
              const ProductDetailsHeader(),
              const SizedBox(
                height: kToolbarHeight / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DetailedProductImage(
                      deviceSize: _deviceSize, product: product),
                ],
              ),
              const SizedBox(
                height: kToolbarHeight,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                child: Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(36, 8, 36, 0),
                  child: Text('Description: ${product.description}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600))),
              Container(
                margin: const EdgeInsets.fromLTRB(36, 8, 36, 0),
                child: Text('Price: ${product.price.toString()} \$',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(36, 8, 36, 0),
                  child: Text(
                      product.quantity != 0
                          ? 'Quantity: ${product.quantity.toString()} pcs.'
                          : 'Sorry! This product is out of stock\nIt will be available soon.\nStay tuned',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500))),
            ],
          ),
        ),
      ),
    );
  }
}
