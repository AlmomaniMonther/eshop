import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, Product> _cartList = {};
  Map<String, Product> get cartList {
    return {..._cartList};
  }

  void clearCartList() {
    _cartList = {};
    notifyListeners();
  }

  int get itemCount {
    return _cartList.length;
  }

//* this method let's the user to add product to the cart */
  void addProductToCart(Product product, int maxProductQuantity) {
    //PS: maximum quantity that user can purchase is product quantity in the store

    //this if check is to ensure that the user can purchase only the quantity in the store
    if (!_cartList.containsKey(product.id) ||
        _cartList[product.id]!.orderedQuantity! < maxProductQuantity) {
      //this if check is to ensure if the product already exists in the cart then add one to the ordered Quantity
      if (_cartList.containsKey(product.id)) {
        _cartList.update(
          product.id,
          (existingValue) => Product(
              id: existingValue.id,
              title: existingValue.title,
              description: existingValue.description,
              price: existingValue.price,
              quantity: existingValue.quantity,
              image: existingValue.image,
              category: existingValue.category,
              orderedQuantity: existingValue.orderedQuantity! + 1),
        );
      } else {
        //if the product not exists in the cart then add it to the cart with one "ordered quantity"
        _cartList.putIfAbsent(
            product.id,
            () => Product(
                id: product.id,
                category: product.category,
                title: product.title,
                description: product.description,
                price: product.price,
                quantity: product.quantity,
                orderedQuantity: 1,
                image: product.image));
      }
      //show a message to the user
      Fluttertoast.showToast(
        msg: 'Product added successfully to your cart',
        backgroundColor: Colors.green.shade800,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      //show a message to the user if no more products in the store
      Fluttertoast.showToast(
        msg: 'Sorry, no more products in the store',
        backgroundColor: Colors.red.shade800,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    notifyListeners();
  }

//* this method let's the user to remove Single Product from the cart */
  void removeSingleProduct(String productId) {
    if (_cartList[productId]!.orderedQuantity! > 1) {
      _cartList.update(
        productId,
        (exValue) => Product(
            id: exValue.id,
            title: exValue.title,
            description: exValue.description,
            price: exValue.price,
            image: exValue.image,
            quantity: exValue.quantity,
            category: exValue.category,
            orderedQuantity: exValue.orderedQuantity! - 1),
      );
    } else {
      _cartList.remove(productId);
    }
    notifyListeners();
  }

//* this method to get the total price for every products ordered*/
  double totalPrice(String productId) {
    double _oneProductPrice = _cartList[productId]!.price;
    return _oneProductPrice *
        double.parse(_cartList[productId]!.orderedQuantity.toString());
  }

//* this method to get the total order price */
  double totalOrderPrice() {
    double total = 0.0;

    _cartList.forEach((key, value) {
      total += value.price * value.orderedQuantity!.toDouble();
    });
    return total;
  }

//* this method to get the ordered quantity of every item in the cart */
  int totalOrderQuantity() {
    int total = 0;

    _cartList.forEach((key, value) {
      total += value.orderedQuantity!;
    });

    return total;
  }

//* this method let's the user to add Single Product to the cart */
  void addSingleProduct(String productId) {
    if (_cartList[productId]!.orderedQuantity! <
        _cartList[productId]!.quantity) {
      _cartList.update(
        productId,
        (exValue) => Product(
            id: exValue.id,
            category: exValue.category,
            title: exValue.title,
            description: exValue.description,
            price: exValue.price,
            image: exValue.image,
            quantity: exValue.quantity,
            orderedQuantity: (exValue.orderedQuantity! + 1)),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry, no more products in the store',
        backgroundColor: Colors.red.shade800,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    notifyListeners();
  }
}
