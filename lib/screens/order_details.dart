import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:pay/pay.dart';
//import 'package:eshop/helpers/orders_helper.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({required this.userId, required this.orderID, Key? key})
      : super(key: key);
  final String userId;
  final String orderID;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Map<String, dynamic> details = {};

//** This method is called to get the order details from the database */
  Future<void> getOrderDetails() async {
    try {
      var orderDetails = await FirebaseFirestore.instance
          .collection('usersOrders')
          .doc(widget.userId)
          .collection('orderedProducts')
          .doc(widget.orderID)
          .get();

      details.addAll(orderDetails.data()!);
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14,
        backgroundColor: Colors.red.shade900,
        textColor: Colors.white,
      );
    }
  }

//** This is the payment method
//* We could enable it if the market supports payment using Apple or Google pay */
  // Future<void> payment(double totalOrderPrice) async {
  //   final _paymentItems = [
  //     PaymentItem(
  //       label: 'Total',
  //       amount: totalOrderPrice.toString(),
  //       status: PaymentItemStatus.final_price,
  //     )
  //   ];
  //   final Pay _payClient =
  //       Pay.withAssets(const ['default_payment_profile_google_pay.json']);
  //   try {
  //     final result = await _payClient.showPaymentSelector(
  //       provider: PayProvider.google_pay,
  //       paymentItems: _paymentItems,
  //     );
  //  Order.updateOrderStatus(widget.orderID);
  // setState(() {});

  //     Fluttertoast.showToast(
  //         msg: 'Payment Successful',
  //         gravity: ToastGravity.BOTTOM,
  //         toastLength: Toast.LENGTH_LONG,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green.shade900,
  //         textColor: Colors.white,
  //         fontSize: 14.0);
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //         msg: e.toString(),
  //         gravity: ToastGravity.BOTTOM,
  //         toastLength: Toast.LENGTH_LONG,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red.shade900,
  //         textColor: Colors.white,
  //         fontSize: 14.0);
  //   }
  // }

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
              const OrderDetailsHeader(),
              Expanded(
                child: FutureBuilder(
                  future: getOrderDetails(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: kToolbarHeight / 2,
                            ),
                            Text(
                              'Order Date: ${DateFormat('EEE, dd/MMM/yyyy, HH:mm:ss').format(
                                (details['date']).toDate(),
                              )}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Anton',
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              'Total Price: ${(details['totalOrderPrice']).toString()} \$',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              details['paid'] == true
                                  ? 'Status: Paid'
                                  : 'Waiting for payment',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: details['products'].length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == details['products'].length) {
                                      return Row(
                                        children: [
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              // payment(
                                              //     details['totalOrderPrice']);
                                            },
                                            label: const Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Anton',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            icon: const Icon(Icons.payment),
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color.fromRGBO(
                                                  255, 75, 59, 1),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Card(
                                      elevation: 12,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.network(
                                              details['products'][index]
                                                  ['image']),
                                        ),
                                        title: Text(details['products'][index]
                                            ['title']),
                                        subtitle: Text(
                                            '${details['products'][index]['orderedQuantity'].toString()} pcs. ${details['products'][index]['price'].toString()} \$'),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({
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
          'Order Details',
          style: TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
