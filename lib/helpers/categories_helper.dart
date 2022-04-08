import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Category {
  final String id;
  final String title;
  final File image;
  List<Product> products = [];

  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.products,
  });
}

class CategoriesHelper {
//* This method let's the admin to add a new category */
  static Future<void> addCategory(
      String categoryName, File categoryImage) async {
    try {
      //add category image to firebase_storage has category name
      final ref = FirebaseStorage.instance
          .ref()
          .child('categories')
          .child(categoryName + '.jpg');
      await ref.putFile(categoryImage);
      //getting category image download url
      final imageUrl = await ref.getDownloadURL();
      //set category image url and category name to the database
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryName)
          .set({'name': categoryName, 'imageUrl': imageUrl});

      //show a message to the admin
      Fluttertoast.showToast(
        msg: 'Category added successfully',
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

//* This method let's the admin to delete category */
  static Future<void> removeCategory(String categoryName) async {
    try {
      //delete the category image from the FirebaseStorage
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryName)
          .delete();
      //delete the category data from the database
      await FirebaseStorage.instance
          .ref()
          .child('categories')
          .child(categoryName + '.jpg')
          .delete();
      //show a message to the admin
      Fluttertoast.showToast(
        msg: 'Category deleted successfully',
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
}
