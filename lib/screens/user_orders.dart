import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/user_orders_widgets/no_orders.dart';
import 'order_details.dart';

class UserOrders extends StatelessWidget {
  const UserOrders({required this.userId, required this.userName, Key? key})
      : super(key: key);
  final String userId;
  final String userName;
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
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  '$userName Orders',
                  style: const TextStyle(
                      fontSize: 26,
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('usersOrders')
                    .doc(userId)
                    .collection('orderedProducts')
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshots.data!.docs.isEmpty) {
                    return const NoOrders();
                  }
                  {
                    return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: ((context, index) => Card(
                            elevation: 12,
                            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: ListTile(
                              title: Text(
                                  'Order № ${(DateTime.parse(snapshots.data!.docs[index].id)).millisecondsSinceEpoch}'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetails(
                                      userId: userId,
                                      orderID: snapshots.data!.docs[index].id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
