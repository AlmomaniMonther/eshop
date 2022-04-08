import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/user_account_screen_widgets/change_location_button.dart';
import '../widgets/user_account_screen_widgets/change_mobile_number_button.dart';
import '../widgets/user_account_screen_widgets/change_user_image.dart';
import '../widgets/user_account_screen_widgets/change_username_button.dart';
import '../widgets/user_account_screen_widgets/user_account_header.dart';
import '../widgets/user_account_screen_widgets/user_data_detailed.dart';

class UserAccount extends StatelessWidget {
  UserAccount({Key? key}) : super(key: key);
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kToolbarHeight / 2,
              ),
              const UserAccountHeader(),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                UserDetailedImage(
                                  userImageUrl: snapshot.data!['image_url'],
                                ),
                                ChangeImageButton(context: context)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UsernameDetailed(
                              username: snapshot.data!['username'],
                            ),
                            ChangeUsernameButton(context: context)
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        UserEmailDetailed(email: snapshot.data!['email']),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: UserLocationDetailed(
                                location: snapshot.data!['location'],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ChangeLocationButton(context: context),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: MobileNumberDetailed(
                                  mobileNumber: snapshot.data!['mobileNumber']),
                            ),
                            ChangeMobileNumberButton(context: context)
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
