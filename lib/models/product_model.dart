class Product {
  String? id;
  String name, description, category, imageUrl;
  double price;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
  });
}