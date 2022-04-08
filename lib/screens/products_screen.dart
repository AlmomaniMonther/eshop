import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/screens/product_details_screen.dart';
import 'package:eshop/models/product_model.dart';
import 'package:flutter/material.dart';
import '../widgets/product_screen_widgets/add_product_button.dart';
import '../widgets/product_screen_widgets/add_product_to_cart_button.dart';
import '../widgets/product_screen_widgets/product_image.dart';
import '../widgets/product_screen_widgets/product_name_text.dart';
import '../widgets/product_screen_widgets/quantity_text.dart';
import '../widgets/product_screen_widgets/remove_product_button.dart';
import '../widgets/product_screen_widgets/update_quantity_button.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;
  final bool isAdmin;
  const ProductsScreen(this.categoryName, this.isAdmin, {Key? key})
      : super(key: key);

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
            ProductScreenHeader(isAdmin: isAdmin, categoryName: categoryName),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .doc(categoryName)
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/empty_cart.png',
                          color: Colors.white,
                        ),
                        const Text(
                          'No products yet\nThe Category is empty!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Anton',
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: GridTile(
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                ProductImage(
                                  productImageUrl: snapshot.data!.docs[index]
                                      ['productImageUrl'],
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.black12),
                                  child: GridTileBar(
                                    backgroundColor: Colors.transparent,
                                    subtitle: QuantityText(
                                      quantity: snapshot.data!.docs[index]
                                          ['quantity'],
                                    ),
                                    title: ProductNameText(
                                      productName: snapshot.data!.docs[index]
                                          ['productName'],
                                    ),
                                    leading: isAdmin
                                        ? RemoveProductButton(
                                            categoryName: categoryName,
                                            productName: snapshot.data!
                                                .docs[index]['productName'],
                                            quantity: snapshot.data!.docs[index]
                                                ['quantity'],
                                          )
                                        : null,
                                    trailing: isAdmin
                                        ? UpdateQuantityButton(
                                            categoryName: categoryName,
                                            productName: snapshot.data!
                                                .docs[index]['productName'],
                                            quantity: snapshot.data!.docs[index]
                                                ['quantity'],
                                          )
                                        : snapshot.data!.docs[index]
                                                    ['quantity'] !=
                                                0
                                            ? AddProductToCartButton(
                                                id: snapshot.data!.docs[index]
                                                    ['id'],
                                                description: snapshot.data!
                                                    .docs[index]['description'],
                                                title: snapshot.data!
                                                    .docs[index]['productName'],
                                                quantity: snapshot.data!
                                                    .docs[index]['quantity'],
                                                imageUrl:
                                                    snapshot.data!.docs[index]
                                                        ['productImageUrl'],
                                                price: snapshot
                                                    .data!.docs[index]['price'],
                                                category: categoryName,
                                              )
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    product: Product(
                                      id: snapshot.data!.docs[index]['id'],
                                      description: snapshot.data!.docs[index]
                                          ['description'],
                                      category: categoryName,
                                      title: snapshot.data!.docs[index]
                                          ['productName'],
                                      quantity: snapshot.data!.docs[index]
                                          ['quantity'],
                                      image: snapshot.data!.docs[index]
                                          ['productImageUrl'],
                                      price: snapshot.data!.docs[index]
                                          ['price'],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductScreenHeader extends StatelessWidget {
  const ProductScreenHeader({
    Key? key,
    required this.isAdmin,
    required this.categoryName,
  }) : super(key: key);

  final bool isAdmin;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        Text(
          '$categoryName Products',
          style: const TextStyle(
              fontSize: 26, fontFamily: 'Anton', fontWeight: FontWeight.w500),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        if (isAdmin) AddProductButton(categoryName: categoryName),
      ],
    );
  }
}
