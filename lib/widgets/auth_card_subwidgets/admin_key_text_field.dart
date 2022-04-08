import 'package:flutter/material.dart';

class AdminKeyTextField extends StatelessWidget {
  const AdminKeyTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey('adminKey'),
      autocorrect: false,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Admin Key'),
          hintText: 'Admin key provided by the market'),
      validator: (value) {
        if (value!.isEmpty || value != '123456') {
          return 'Please enter your admin key';
        }
        return null;
      },
    );
  }
}
