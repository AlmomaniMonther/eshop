import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeImageButton extends StatelessWidget {
  const ChangeImageButton({Key? key, required this.context}) : super(key: key);
  final BuildContext context;
  void changeImage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    File? _userImage;
    void changeImageFromCamera() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxHeight: 150,
          maxWidth: 150);

      final pickedImageFile = File(pickedImage!.path);

      _userImage = pickedImageFile;

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(userId + '.jpg');
      await ref.putFile(_userImage!);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'image_url': url});
    }

    void changeImageFromGallery() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxHeight: 150,
          maxWidth: 150);

      final pickedImageFile = File(pickedImage!.path);

      _userImage = pickedImageFile;

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(userId + '.jpg');
      await ref.putFile(_userImage!);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'image_url': url});
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Gallery'),
                    onTap: () async {
                      changeImageFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    changeImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          changeImage();
        },
        child: const Text(
          'Change Image',
          style: TextStyle(
              color: Color.fromARGB(255, 153, 66, 0),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ));
  }
}
