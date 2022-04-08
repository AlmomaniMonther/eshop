import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeMobileNumberButton extends StatelessWidget {
  const ChangeMobileNumberButton({Key? key, required this.context})
      : super(key: key);
  final BuildContext context;
  void changeMobileNumber() {
    String newMobileNumber = '';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            clipBehavior: Clip.antiAlias,
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade100,
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Mobile Number'),
                        hintText: 'Enter your new Mobile Number'),
                    onChanged: (value) {
                      newMobileNumber = value;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(255, 75, 59, 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Save'),
                    onPressed: () async {
                      final userId = FirebaseAuth.instance.currentUser!.uid;

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .update({'mobileNumber': newMobileNumber});

                      Navigator.of(context).pop();
                    },
                  )
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        changeMobileNumber();
      },
      child: const Text(
        'Change Number',
        style: TextStyle(
            color: Color.fromARGB(255, 153, 66, 0),
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
