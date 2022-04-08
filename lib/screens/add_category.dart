import 'dart:io';

import 'package:eshop/helpers/categories_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/add_category_widgets/add_category_header.dart';
import '../widgets/add_category_widgets/category_title_field.dart';
import '../widgets/add_category_widgets/chosen_category_image.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String title = '';
  String id = '';
  File? _cachedImage;
  File? _storedImage;
  bool isLoading = false;

//* Choose image to add to the category */
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _cachedImage = File(imageFile.path);
    });
    final appDirectory = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    _storedImage =
        await File(imageFile.path).copy('${appDirectory.path}/$fileName');
  }

//* This method to save the category */
  void saveCategory() async {
    if (_storedImage == null) {
      Fluttertoast.showToast(
          msg: "Category image should not be empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 175, 33, 23),
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    } else if (title == '') {
      Fluttertoast.showToast(
          msg: "Category title should not be empty",
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
      await CategoriesHelper.addCategory(title, _storedImage!);
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
            const AddCategoryHeader(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryTitleField(
                      categoryTitleCallback: (categoryTitle) => setState(() {
                        title = categoryTitle;
                        id = categoryTitle;
                      }),
                    ),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_storedImage != null)
                          ChosenCategoryImage(storedImage: _cachedImage),
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
                    isLoading
                        ? const Padding(
                            padding: EdgeInsets.only(right: 70, top: 20),
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: saveCategory,
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(255, 75, 59, 1),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Save Category',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Anton',
                                color: Colors.white,
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
