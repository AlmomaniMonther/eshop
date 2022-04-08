import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import '../helpers/products_helper.dart';
import '../widgets/add_product_widgets/add_product_header.dart';
import '../widgets/add_product_widgets/chosen_product_image.dart';
import '../widgets/add_product_widgets/product_description_field.dart';
import '../widgets/add_product_widgets/product_price_field.dart';
import '../widgets/add_product_widgets/product_title_field.dart';

class AddProduct extends StatefulWidget {
  final String categoryName;
  const AddProduct(this.categoryName, {Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String title = '';
  String id = '';
  String description = '';
  double price = 0.0;
  int quantity = 1;
  File? _storedImage;
  bool isLoading = false;

//* Choose image to add to the product */
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }

    final appDirectory = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    _storedImage =
        await File(imageFile.path).copy('${appDirectory.path}/$fileName');
    setState(() {});
  }

//* This method to save the product */
  void saveProduct() async {
    if (_storedImage == null) {
      Fluttertoast.showToast(
          msg: "Product image should not be empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 175, 33, 23),
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    } else if (title == '' || description == '' || price == 0.0) {
      Fluttertoast.showToast(
          msg: "All fields are required and should not be empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 175, 33, 23),
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }
    {
      setState(() {
        isLoading = true;
      });
      await ProductsHelper.addProductToCategory(id, title, _storedImage!,
          description, price, quantity, widget.categoryName);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight / 2,
            ),
            const AddProductHeader(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ProductTitleField(
                        productTitleCallback: (productTitle) => setState(() {
                              id = productTitle + widget.categoryName;
                              title = productTitle;
                            })),
                    const SizedBox(
                      height: 12,
                    ),
                    ProductDescriptionField(
                        productDescriptionCallback: (productDescription) =>
                            setState(() {
                              description = productDescription;
                            })),
                    const SizedBox(
                      height: 12,
                    ),
                    ProductPriceField(
                        productPriceCallback: (productPrice) => setState(() {
                              price = productPrice;
                            })),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Quantity: ',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Anton',
                              letterSpacing: 1),
                        ),
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity = quantity - 1;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.remove,
                            size: 26,
                          ),
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Anton',
                              letterSpacing: 1),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity = quantity + 1;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 26,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_storedImage != null)
                          ChosenProductImage(storedImage: _storedImage),
                        TextButton(
                          onPressed: () async {
                            await _pickImage();
                          },
                          child: Text(
                            _storedImage == null ? 'Set Image' : 'Change Image',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Anton',
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: saveProduct,
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: const Text(
                              'Save Product',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Anton',
                              ),
                            ))
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
