class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  int quantity;
  int? orderedQuantity = 0;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.quantity,
      required this.category,
      this.orderedQuantity});
}
