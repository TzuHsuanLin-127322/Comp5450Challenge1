// product_form_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_view_model.dart';
import 'product_model.dart';
import 'dart:io';

class ProductFormPage extends StatelessWidget {
  final bool isEditMode;
  final Map<String, dynamic>? initialData;

  ProductFormPage({required this.isEditMode, this.initialData});

  @override
  Widget build(BuildContext context) {
    // Get the ProductViewModel from Provider
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        if (isEditMode && initialData != null) {
          viewModel.setProduct(Product(
            name: initialData!['name'],
            price: initialData!['price'],
            comparePrice: initialData!['comparePrice'],
            images: List<String>.from(initialData!['images']),
          ));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(isEditMode ? 'Edit Product' : 'Add Product'),
            actions: [
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    viewModel.saveProduct();
                    Navigator.pop(context, viewModel.product);
                  }
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: viewModel.product.name),
                  onChanged: (value) => viewModel.product.name = value,
                  decoration: _inputDecoration('Product Name'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(text: viewModel.product.price),
                  onChanged: (value) => viewModel.product.price = value,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Price'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(text: viewModel.product.comparePrice),
                  onChanged: (value) => viewModel.product.comparePrice = value,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Compare-at Price'),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    if (viewModel.product.images.isNotEmpty)
                      GestureDetector(
                        onTap: viewModel.pickImages,
                        child: Text('Add Images', style: TextStyle(color: Colors.blue)),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                viewModel.product.images.isEmpty
                    ? GestureDetector(
                  onTap: viewModel.pickImages,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text('Add images')),
                  ),
                )
                    : GridView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.product.images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.file(
                            File(viewModel.product.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => viewModel.removeImage(index),
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }
}
