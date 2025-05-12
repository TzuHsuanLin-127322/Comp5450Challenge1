// edit_product_page.dart
import 'package:flutter/material.dart';
import 'product_form_page.dart';
import 'product_view_model.dart';
import 'package:provider/provider.dart';
import 'product_model.dart';

class EditProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  EditProductPage({required this.productData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(
        product: Product(
          name: productData['name'],
          price: productData['price'],
          comparePrice: productData['comparePrice'],
          images: List<String>.from(productData['images']),
        ),
      ),
      child: ProductFormPage(isEditMode: true, initialData: productData),
    );
  }
}
