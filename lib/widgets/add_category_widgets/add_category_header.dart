import 'package:flutter/material.dart';

class AddCategoryHeader extends StatelessWidget {
  const AddCategoryHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        const Text(
          'Add Category',
          style: TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
