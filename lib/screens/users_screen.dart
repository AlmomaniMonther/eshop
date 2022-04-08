import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user_orders.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List usersData = [];
  List usersIDs = [];

  //** This method will get all the users in the database
  //* then will show all the clients in the database
  //* and the admins accounts will not be shown */
  Future<void> getAllUsers() async {
    List usersList;
    var users = await FirebaseFirestore.instance.collection('users').get();
    usersList = users.docs;

    for (int i = 0; i < usersList.length; i++) {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(users.docs[i].id)
          .get();
      usersData.add(userData.data());
      usersIDs.add(usersList[i].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
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
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight / 2,
            ),
            const UsersScreenHeader(),
            Expanded(
                child: FutureBuilder(
              future: getAllUsers(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                {
                  return ListView.builder(
                    itemCount: usersIDs.length,
                    itemBuilder: ((context, index) {
                      if (!usersData[index]['isAdmin']) {
                        return Card(
                          elevation: 12,
                          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Text(usersData[index]['username']),
                            subtitle: Text(usersIDs[index]),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(usersData[index]['image_url']),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserOrders(
                                        userId: usersIDs[index],
                                        userName: usersData[index]['username'],
                                      )));
                            },
                          ),
                        );
                      } else {
                        return const SizedBox(
                          height: 0,
                          width: 0,
                        );
                      }
                    }),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}

class UsersScreenHeader extends StatelessWidget {
  const UsersScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        const Text(
          'Users',
          style: TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
