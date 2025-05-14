import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  
import 'package:provider/provider.dart';
import 'product_view_model.dart';
import 'product_model.dart';

class ProductFormPage extends StatefulWidget {
  final bool isEditMode;
  final Map<String, dynamic>? initialData;
  const ProductFormPage({
    super.key,
    required this.isEditMode,
    this.initialData,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _compareCtrl;

  @override
  void initState() {
    super.initState();
    final vm = context.read<ProductViewModel>();

    if (widget.isEditMode && widget.initialData != null) {
      vm.product = Product.fromMap(widget.initialData!);
    }

    _nameCtrl = TextEditingController(text: vm.product.name);
    _priceCtrl = TextEditingController(text: vm.product.price.toString());       // e.g. 23.99
    _compareCtrl =
        TextEditingController(text: vm.product.comparePrice.toString());        // e.g. 30.00
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _compareCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (_, vm, __) => Scaffold(
        appBar: AppBar(
          title: Text(widget.isEditMode ? 'Edit Product' : 'Add Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _field(
                controller: _nameCtrl,
                label: 'Product Name',
                onChanged: (v) => vm.product.name = v,
              ),
              const SizedBox(height: 12),
              _moneyField(
                controller: _priceCtrl,
                label: 'Price (\$)',
                onChanged: (v) => _setMoney(vm.product.price, v),
              ),
              const SizedBox(height: 12),
              _moneyField(
                controller: _compareCtrl,
                label: 'Compare‑at price(\$)',
                onChanged: (v) => _setMoney(vm.product.comparePrice, v),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Product Image',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  if (vm.product.images.isNotEmpty)
                    GestureDetector(
                      onTap: vm.pickImages,
                      child: const Text('+ Add Images',
                          style: TextStyle(color: Colors.blue)),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              vm.product.images.isEmpty
                  ? _emptyImageBox(onTap: vm.pickImages)
                  : _imageGrid(vm),
              if (widget.isEditMode) ...[
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {
                      vm.deleteProduct();
                      Navigator.pop(context, {'delete': true});
                    },
                    child: const Text('Delete Product',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 45),
          child: OutlinedButton(
            onPressed: () {
              vm.saveProduct();
              Navigator.pop(context, vm.product);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.black),
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  // allow both numbers and decimal points
  Widget _moneyField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
  }) =>
      TextField(
        controller: controller,
        keyboardType:
        const TextInputType.numberWithOptions(decimal: true, signed: false),
        decoration: _inputDecoration(label),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'[^0-9.]'))
        ],
        onChanged: onChanged,
      );

  void _setMoney(Money money, String input) {
    final cleanedInput = input.replaceAll(RegExp(r'[^0-9.]'), '');
    if (cleanedInput.isNotEmpty) {
      final parts = cleanedInput.split('.');
      money.major = int.tryParse(parts[0]) ?? 0;
      money.minor = parts.length > 1
          ? int.tryParse(parts[1].padRight(2, '0').substring(0, 2)) ?? 0
          : 0;
    }
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
    required ValueChanged<String> onChanged,
  }) =>
      TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: _inputDecoration(label),
        onChanged: onChanged,
      );

  Widget _emptyImageBox({required VoidCallback onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: const Text('+ Add images', style: TextStyle(color: Colors.blue)), 
    ),
  );

  Widget _imageGrid(ProductViewModel vm) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: vm.product.images.length + 1,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1,
    ),
    itemBuilder: (_, i) {
      if (i == vm.product.images.length) {
        return InkWell(
          onTap: vm.pickImages,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add),
          ),
        );
      }
      final path = vm.product.images[i];
      return Stack(
        fit: StackFit.expand,
        children: [
          path.startsWith('http')
              ? Image.network(path, fit: BoxFit.cover)
              : Image.file(File(path), fit: BoxFit.cover),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => vm.removeImage(i),
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(2),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      );
    },
  );

  InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
  );
}
