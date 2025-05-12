// add_product_page.dart
import 'package:flutter/material.dart';
import 'product_form_page.dart';
import 'product_view_model.dart';
import 'package:provider/provider.dart';
import 'product_model.dart';

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(product: Product(name: '', price: '', comparePrice: '', images: [])),
      child: ProductFormPage(isEditMode: false),
    );
  }
}
