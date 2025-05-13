import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_form_page.dart';
import 'product_model.dart';
import 'product_view_model.dart';

class EditProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  const EditProductPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(product: Product.fromMap(productData)),
      child: ProductFormPage(
        isEditMode: true,
        initialData: productData,
      ),
    );
  }
}
