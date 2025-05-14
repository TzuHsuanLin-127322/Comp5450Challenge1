class Money {
  int major;
  int minor;

  Money({required this.major, required this.minor});

  @override
  String toString() => '$major.${minor.toString().padLeft(2, '0')}';

  factory Money.fromMap(Map<String, dynamic> m,
      {String majorKey = 'major', String minorKey = 'minor'}) =>
      Money(major: m[majorKey] ?? 0, minor: m[minorKey] ?? 0);

  Map<String, int> toMap(
      {String majorKey = 'major', String minorKey = 'minor'}) =>
      {majorKey: major, minorKey: minor};
}

class Product {
  String id;
  String name;
  Money price;
  Money comparePrice;
  List<String> images;

  Product({
    this.id = '',
    required this.name,
    required this.price,
    required this.comparePrice,
    required this.images,
  });

  static Product empty() => Product(
    name: '',
    price: Money(major: 0, minor: 0),
    comparePrice: Money(major: 0, minor: 0),
    images: [],
  );

  Product copy() => Product(
    id: id,
    name: name,
    price: Money(major: price.major, minor: price.minor),
    comparePrice: Money(
        major: comparePrice.major, minor: comparePrice.minor),
    images: List.from(images),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    ...price.toMap(majorKey: 'priceMajor', minorKey: 'priceMinor'),
    ...comparePrice.toMap(
        majorKey: 'compareMajor', minorKey: 'compareMinor'),
    'images': images,
  };

  factory Product.fromMap(Map<String, dynamic> m) => Product(
    id: m['id'] ?? '',
    name: m['name'] ?? '',
    price: Money.fromMap(m,
        majorKey: 'priceMajor', minorKey: 'priceMinor'),
    comparePrice: Money.fromMap(m,
        majorKey: 'compareMajor', minorKey: 'compareMinor'),
    images: List<String>.from(m['images'] ?? []),
  );

  void ensureId([String? fixed]) {
    if (id.isEmpty) id = fixed ?? DateTime.now().millisecondsSinceEpoch.toString();
  }
}
