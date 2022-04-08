import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/product_model.dart';

class ProductsHelper {
  //* This method let's the ADMIN to add the products to the category depends to... */
  static Future<void> addProductToCategory(
      String id,
      String productName,
      File productImage,
      String productDescription,
      double productPrice,
      int productQuantity,
      String categoryName) async {
    try {
      // Add the product image to a folder for the category products
      // each folder contains all the products images
      final ref = FirebaseStorage.instance
          .ref()
          .child(categoryName + 'products')
          .child(productName + '.jpg');
      await ref.putFile(productImage);

      //getting product image download url
      final productImageUrl = await ref.getDownloadURL();

      //set product details to a folder (category) in the database
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryName)
          .collection('products')
          .doc(productName)
          .set({
        'id': id,
        'productName': productName,
        'productImageUrl': productImageUrl,
        'description': productDescription,
        'price': productPrice,
        'quantity': productQuantity,
        'category': categoryName,
      });

      //show a message to the admin
      Fluttertoast.showToast(
        msg: 'Product added successfully',
        backgroundColor: Colors.green.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (error) {
      //show a message to the admin
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.red.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //* This method let's the ADMIN to update the product quantity by adding one  */
  static Future<void> updateQuantity(
      String productName, int quantity, String category) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(category)
          .collection('products')
          .doc(productName)
          .update({'quantity': quantity + 1});
    } catch (error) {
      //show a message to the admin
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.red.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //** This method to update the product quantity
  //* by subtract ordered quantity by the user from the product quantity **/
  static Future<void> updateQuantityAfterOrder(List<Product> products) async {
    try {
      for (int i = 0; i < products.length; i++) {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(products[i].category)
            .collection('products')
            .doc(products[i].title)
            .update({
          'quantity': products[i].quantity - products[i].orderedQuantity!
        });
      }
    } catch (error) {
      //show a message to the admin
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.red.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //** This method let's the ADMIN to update the product quantity by subtract one
  //* or delete the product if it's quantity is 0 */
  static Future<void> removeProduct(
      String productName, int quantity, String category) async {
    try {
      if (quantity > 1) {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(category)
            .collection('products')
            .doc(productName)
            .update({'quantity': quantity - 1});
      } else {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(category)
            .collection('products')
            .doc(productName)
            .delete();
        await FirebaseStorage.instance
            .ref()
            .child(category + 'products')
            .child(productName + '.jpg')
            .delete();
      }
    } catch (error) {
      //show a message to the admin
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.red.shade800,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
