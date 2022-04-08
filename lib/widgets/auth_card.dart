import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/widgets/auth_card_subwidgets/location_getter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_card_subwidgets/admin_key_text_field.dart';
import 'auth_card_subwidgets/email_text_field.dart';
import 'auth_card_subwidgets/mobile_text_field.dart';
import 'auth_card_subwidgets/password_text_field.dart';
import 'auth_card_subwidgets/user_image.dart';
import 'auth_card_subwidgets/username_text_field.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _username = '';
  String _mobileNumber = '';
  File? _userImage;
  bool isLogin = true;
  bool isLoading = false;
  bool isAdmin = false;
  String _location = '';

//** This method to validate the form and ensure
//* that the user picked image and location */
  void _submitAuthForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImage == null && !isLogin) {
      toastMsg(true, 'please pick an image');
      return;
    }
    if (_location == '' && !isLogin && !isAdmin) {
      toastMsg(true, 'please add your location');
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      _authentication(_email, _username, _password, isLogin, _userImage,
          _location, _mobileNumber);
    }
  }

//** This method is called to show a message to the user */
  Future<void> toastMsg(bool isError, String message) async {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: !isError ? Colors.green.shade800 : Colors.red.shade800,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
    );
  }

//////////////////////////
//** These tow methods are used to define where to show a Progress indicator */
  void isLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void isLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

//////////////////////////
//** This is the authentication method */
  void _authentication(
      String email,
      String username,
      String password,
      bool isLogin,
      File? imageFile,
      String location,
      String mobileNumber) async {
    UserCredential userCredential;
    try {
      //**if the auth type is "LOGIN"*/
      if (isLogin == true) {
        try {
          isLoadingTrue();
          userCredential = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          isLoadingFalse();
          toastMsg(false, 'Logged in successfully');
        } on FirebaseAuthException catch (error) {
          isLoadingFalse();
          if (error.code == 'user-not-found') {
            toastMsg(true, 'No user found for that email!');
          } else if (error.code == 'wrong-password') {
            toastMsg(true, 'Wrong password!');
          }
        } catch (logInError) {
          isLoadingFalse();
          toastMsg(true, logInError.toString());
        }
        //**if the auth type is "SIGNUP"*/
      } else {
        try {
          isLoadingTrue();
          userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          final ref = FirebaseStorage.instance
              .ref()
              .child('user_image')
              .child(userCredential.user!.uid + '.jpg');
          await ref.putFile(imageFile!);
          final url = await ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': username,
            'email': email,
            'image_url': url,
            'isAdmin': isAdmin,
            'location': location,
            'mobileNumber': mobileNumber,
          });
          isLoadingFalse();
          toastMsg(false, 'Signed up successfully');
        } on FirebaseAuthException catch (e) {
          isLoadingFalse();
          if (e.code == 'weak-password') {
            toastMsg(true, 'Your password is too weak');
          } else if (e.code == 'email-already-in-use') {
            toastMsg(
                true,
                'The account already exists for that email'
                'Your password is too weak');
          }
        } catch (signUpError) {
          isLoadingFalse();
          toastMsg(true, signUpError.toString());
        }
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        toastMsg(true, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: AnimatedContainer(
        height: !isLogin ? 350 : 270,
        width: _deviceSize.width * 0.9,
        constraints: BoxConstraints(
          minHeight: !isLogin ? 320 : 250,
        ),
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isLogin)
                  UserImage(
                    userImageCallback: (value) => setState(() {
                      _userImage = value;
                    }),
                  ),
                EmailTextField(
                  emailCallback: (value) => setState(() {
                    _email = value;
                  }),
                ),
                if (!isLogin)
                  UserNameTextField(
                    usernameCallback: (value) => setState(() {
                      _username = value;
                    }),
                  ),
                if (!isAdmin && !isLogin)
                  MobileTextField(
                    mobileNumberCallback: (value) => setState(() {
                      _mobileNumber = value;
                    }),
                  ),
                PasswordTextField(
                  passwordCallback: (value) => setState(() {
                    _password = value;
                  }),
                ),
                if (isAdmin && !isLogin) const AdminKeyTextField(),
                const SizedBox(
                  height: 12,
                ),
                if (!isAdmin && !isLogin)
                  LocationGetter(
                    locationCallback: (value) => setState(() {
                      _location = value;
                    }),
                  ),
                if (isLoading) const CircularProgressIndicator(),
                if (!isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!isLogin)
                        Row(
                          children: [
                            const Text('User:'),
                            Radio<bool>(
                              value: false,
                              groupValue: isAdmin,
                              onChanged: (bool? value) {
                                setState(
                                  () {
                                    isAdmin = value!;
                                  },
                                );
                              },
                            ),
                            const Text('Admin:'),
                            Radio<bool>(
                              value: true,
                              groupValue: isAdmin,
                              onChanged: (bool? value) {
                                setState(
                                  () {
                                    isAdmin = value!;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ElevatedButton(
                          onPressed: _submitAuthForm,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8)),
                          child: Text(isLogin ? 'Login' : 'SignUp')),
                    ],
                  ),
                if (!isLoading)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin
                          ? 'Create New Account'
                          : 'Already Have An Account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
