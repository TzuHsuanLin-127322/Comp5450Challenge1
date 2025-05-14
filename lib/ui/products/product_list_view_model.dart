import 'package:flutter/material.dart';
import '../../model/product_model.dart';

class ProductListViewModel extends ChangeNotifier {
  final List<Product> _products = [];
  bool loading = false;

  List<Product> get products => List.unmodifiable(_products);


  void add(Product p) {
    _products.add(p..ensureId());
    notifyListeners();
  }

  void update(Product oldP, Product newP) {
    final idx = _products.indexOf(oldP);
    if (idx != -1) _products[idx] = newP..ensureId(oldP.id);
    notifyListeners();
  }

  void remove(Product p) {
    _products.remove(p);
    notifyListeners();
  }
}
