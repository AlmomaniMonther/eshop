import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final String _founderEmail = 'malmomani29.ru@gmail.com';

  TextEditingController feedbackBody = TextEditingController();
  String _feedback = '';
  TextEditingController senderEmail = TextEditingController();
  TextEditingController subject = TextEditingController();

  String? _imagePath;
  //**This method to pick screenshot to attach with the feedback email */
  void _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final _xImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (_xImage != null) {
      setState(() {
        _imagePath = _xImage.path;
      });
    } else {
      _imagePath = null;
    }
  }

//** This method to send feedback email */
  void sendEmail() async {
    final mail = Email(
        recipients: ['malmomani29.ru@gmail.com'],
        body: 'from ${senderEmail.text} \n$_feedback',
        attachmentPaths: _imagePath == null ? null : [_imagePath!],
        subject: subject.text.isEmpty ? 'no subject' : subject.text,
        isHTML: false);

    await FlutterEmailSender.send(mail);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: const Text(
            'Thanks for your feedback we will respond to you as soon as possible')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(top: kToolbarHeight / 2),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Color.fromARGB(255, 252, 97, 25),
                      Color.fromRGBO(255, 193, 7, 1),
                      Color.fromRGBO(254, 201, 78, 1),
                    ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Expanded(
                  child: Text(
                    'Send me your feedback',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Anton',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(onPressed: sendEmail, icon: const Icon(Icons.send))
              ],
            ),
          ),
          preferredSize: const Size(double.infinity, kToolbarHeight)),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 193, 7, 0.7),
              Color.fromRGBO(255, 75, 59, 1)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kToolbarHeight * 1.3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: senderEmail,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        String pattern =
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?)*$";
                        RegExp regex = RegExp(pattern);
                        if (value == null ||
                            value.isEmpty ||
                            !regex.hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: 'Enter your email address',
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _founderEmail,
                      readOnly: true,
                      decoration: const InputDecoration(
                        label: Text("to:"),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: subject,
                      decoration: const InputDecoration(
                        label: Text("Subject"),
                        hintText: 'Enter subject',
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 15,
                      style: const TextStyle(fontSize: 20),
                      controller: feedbackBody,
                      onChanged: (value) {
                        setState(() {
                          _feedback = value;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Enter your feedback here...",
                        filled: true,
                        fillColor: Colors.white60,
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: _imagePath != null
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.end,
                      children: [
                        if (_imagePath != null)
                          Container(
                            height: MediaQuery.of(context).size.width * 1 / 3,
                            width: MediaQuery.of(context).size.width * 1 / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(255, 193, 7, 0.7),
                                  Color.fromARGB(255, 247, 37, 18)
                                ],
                              ),
                            ),
                            child: Image.file(
                              File(_imagePath!),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          icon: const Icon(
                            Icons.attach_file,
                          ),
                          label: const Text(
                            'Attach Screenshot',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Anton',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
