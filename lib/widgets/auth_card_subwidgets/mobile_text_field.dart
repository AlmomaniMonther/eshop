import 'package:flutter/material.dart';

typedef StringCallback = void Function(String mobileNumber);

class MobileTextField extends StatelessWidget {
  const MobileTextField({Key? key, required this.mobileNumberCallback})
      : super(key: key);
  final StringCallback mobileNumberCallback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey('mobile number'),
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
          label: Text('Mobile Number'), hintText: 'Enter your Mobile Number'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Mobile Number';
        }
        return null;
      },
      onSaved: (value) {
        mobileNumberCallback(value!);
      },
    );
  }
}
