import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef FileCallback = void Function(File userImage);

class UserImage extends StatefulWidget {
  const UserImage({Key? key, required this.userImageCallback})
      : super(key: key);
  final FileCallback userImageCallback;
  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _userImage;
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 150,
        maxWidth: 150);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _userImage = pickedImageFile;
    });
    widget.userImageCallback(_userImage!);
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 150,
        maxWidth: 150);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _userImage = pickedImageFile;
    });
    widget.userImageCallback(_userImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_userImage == null)
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/person.png'),
            backgroundColor: Colors.grey,
          ),
        if (_userImage != null)
          CircleAvatar(radius: 40, backgroundImage: FileImage(_userImage!)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () {
                  _pickImage();
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Add Image')),
            TextButton.icon(
                onPressed: () {
                  _selectImage();
                },
                icon: const Icon(Icons.image_search_outlined),
                label: const Text('Select Image'))
          ],
        ),
      ],
    );
  }
}
