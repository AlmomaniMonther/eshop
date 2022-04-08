import 'package:flutter/material.dart';

typedef StringCallback = void Function(String email);

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key, required this.emailCallback})
      : super(key: key);
  final StringCallback emailCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey('email'),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      decoration: const InputDecoration(
          label: Text('email'), hintText: 'Enter your email address'),
      validator: (value) {
        String pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = RegExp(pattern);
        if (value == null || value.isEmpty || !regex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (value) {
        emailCallback(value!);
      },
    );
  }
}
