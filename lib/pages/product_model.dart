// product_model.dart
class Product {
  String name;
  String price;
  String comparePrice;
  List<String> images;

  Product({
    required this.name,
    required this.price,
    required this.comparePrice,
    required this.images,
  });

// You can also add methods for serialization and deserialization if needed
}