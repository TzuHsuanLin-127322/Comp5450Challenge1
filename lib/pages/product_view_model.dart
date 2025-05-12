// product_view_model.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'product_model.dart';

class ProductViewModel extends ChangeNotifier {
  Product product;

  // Initialize with default values or data
  ProductViewModel({required this.product});

  final ImagePicker _picker = ImagePicker();

  // Methods to update the product data
  void setProduct(Product product) {
    this.product = product;
    notifyListeners();
  }

  // Method to pick images
  Future<void> pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();
    if (picked != null && picked.isNotEmpty) {
      product.images = picked.map((file) => file.path).toList();
      notifyListeners();
    }
  }

  // Method to remove image
  void removeImage(int index) {
    product.images.removeAt(index);
    notifyListeners();
  }

  // Method to save product
  void saveProduct() {
    // Save or process the product (e.g., send data to an API or local storage)
    notifyListeners();
  }

  // Method to delete product
  void deleteProduct() {
    product = Product(name: '', price: '', comparePrice: '', images: []);  // Clear the data
    notifyListeners();
  }
}
