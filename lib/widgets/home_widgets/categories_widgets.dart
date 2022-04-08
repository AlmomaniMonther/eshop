import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/helpers/categories_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../screens/products_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  final bool? isAdmin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
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
                  'No products yet\nThe Store is empty!!',
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
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
                            CategoryImage(
                                imageUrl: snapshot.data!.docs[index]
                                    ['imageUrl']),
                            Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.black12),
                              child: GridTileBar(
                                  backgroundColor: Colors.transparent,
                                  title: CategoryTitle(
                                      title: snapshot.data!.docs[index]
                                          ['name']),
                                  trailing: isAdmin!
                                      ? DeleteCategoryButton(
                                          categoryName: snapshot
                                              .data!.docs[index]['name'],
                                        )
                                      : null),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                snapshot.data!.docs[index]['name'],
                                isAdmin!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class DeleteCategoryButton extends StatelessWidget {
  const DeleteCategoryButton({Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        bool categoryIsEmpty = false;
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryName)
            .collection('products')
            .get()
            .then((value) => categoryIsEmpty = value.docs.isEmpty);

        if (categoryIsEmpty == true) {
          await CategoriesHelper.removeCategory(
            categoryName,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'You cannot delete category\nif it\'s not empty',
            backgroundColor: Colors.red.shade800,
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      icon: const Icon(Icons.delete_outline),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18),
    );
  }
}

class CategoryImage extends StatelessWidget {
  const CategoryImage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
