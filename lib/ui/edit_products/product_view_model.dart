import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  Product product;
  ProductViewModel({required this.product});

  final ImagePicker _picker = ImagePicker();

  void setProduct(Product p) {
    product = p;
    notifyListeners();
  }

  Future<void> pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 85);
    if (picked != null && picked.isNotEmpty) {
      product.images.addAll(picked.map((f) => f.path));
      notifyListeners();
    }
  }

  void removeImage(int idx) {
    product.images.removeAt(idx);
    notifyListeners();
  }

  void saveProduct() => notifyListeners();

  void deleteProduct() {
    product = Product.empty();
    notifyListeners();
  }
}
