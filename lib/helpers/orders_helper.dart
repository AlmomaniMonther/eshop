import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/product_model.dart';
import 'package:eshop/helpers/products_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Order {
//* this method let's the user to make the order */
  static Future<void> makeOrder(
      List<Product> products, double orderPrice) async {
    try {
      // Get the logged in user id
      String userID = FirebaseAuth.instance.currentUser!.uid;
      // Add the order to the database
      //there will be a new order with total order price, date order,
      //order status, ordered products and product details
      //(title, price, image and ordered quantity of the product)
      await FirebaseFirestore.instance
          .collection('usersOrders')
          .doc(userID)
          .collection('orderedProducts')
          .doc(DateTime.now().toIso8601String())
          .set({
        'totalOrderPrice': orderPrice,
        'date': DateTime.now(),
        'paid': false,
        'products': products
            .map(
              (e) => {
                'title': e.title,
                'price': e.price,
                'image': e.image,
                'orderedQuantity': e.orderedQuantity,
              },
            )
            .toList()
      });
      // Update Quantity of the product in the database AFTER ORDER IS DONE
      await ProductsHelper.updateQuantityAfterOrder(products);
      // Show message to the user
      Fluttertoast.showToast(
        msg: 'Order added successfully',
        backgroundColor: Colors.green.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      // Show message to the user
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

//* this method to change order status if the user paid */
  static Future<void> updateOrderStatus(String orderID) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('usersOrders')
        .doc(userID)
        .collection('orderedProducts')
        .doc(orderID)
        .update({'paid': true});
  }
}
