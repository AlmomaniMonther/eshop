import 'package:flutter/material.dart';

class UserAccountHeader extends StatelessWidget {
  const UserAccountHeader({
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
          'My Account',
          style: TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
