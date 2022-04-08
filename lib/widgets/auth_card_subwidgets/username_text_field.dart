import 'package:flutter/material.dart';

typedef StringCallback = void Function(String username);

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({Key? key, required this.usernameCallback})
      : super(key: key);
  final StringCallback usernameCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey('user name'),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
          label: Text('User Name'), hintText: 'Enter your Username'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your User Name';
        }
        return null;
      },
      onSaved: (value) {
        usernameCallback(value!);
      },
    );
  }
}
