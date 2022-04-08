import 'package:flutter/material.dart';

typedef StringCallback = void Function(String password);

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key, required this.passwordCallback})
      : super(key: key);
  final StringCallback passwordCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey('password'),
      autocorrect: false,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password'), hintText: 'Enter your Password'),
      validator: (value) {
        if (value!.isEmpty || value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      onSaved: (value) {
        passwordCallback(value!);
      },
    );
  }
}
