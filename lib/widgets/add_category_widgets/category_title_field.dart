import 'package:flutter/material.dart';

typedef StringCallback = void Function(String categoryTitle);

class CategoryTitleField extends StatelessWidget {
  const CategoryTitleField({
    Key? key,
    required this.categoryTitleCallback,
  }) : super(key: key);
  final StringCallback categoryTitleCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
        hintText: 'Add category title',
      ),
      onChanged: (value) {
        categoryTitleCallback(value);
      },
    );
  }
}
