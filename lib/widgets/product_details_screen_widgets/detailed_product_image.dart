import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class DetailedProductImage extends StatelessWidget {
  const DetailedProductImage({
    Key? key,
    required Size deviceSize,
    required this.product,
  })  : _deviceSize = deviceSize,
        super(key: key);

  final Size _deviceSize;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: const Color.fromARGB(255, 139, 105, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 248, 225),
                  Color.fromARGB(255, 255, 236, 179),
                  Color.fromARGB(255, 253, 228, 153),
                ])),
        height: _deviceSize.height / 3,
        width: _deviceSize.width / 1.2,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              product.image,
              fit: BoxFit.fitHeight,
            )),
      ),
    );
  }
}
