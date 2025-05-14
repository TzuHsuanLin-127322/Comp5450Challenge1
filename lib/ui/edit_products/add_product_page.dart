import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_form_page.dart';
import '../../model/product_model.dart';
import 'product_view_model.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(product: Product.empty()),
      child: const ProductFormPage(isEditMode: false),
    );
  }
}
