// product_list_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product_model.dart';
import 'product_list_view_model.dart';
import '../edit_products/add_product_page.dart';
import '../edit_products/edit_product_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductListViewModel>();


    if (vm.loading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }
    if (vm.products.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add product'),
            onPressed: () => _goAdd(context),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _goAdd(context), child: const Icon(Icons.add)),
      );
    }


    final filtered = _query.isEmpty
        ? vm.products
        : vm.products
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _query = '');
                  },
                ),
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v.trim()),
            ),
          ),
        ),
      ),
      body: filtered.isEmpty
          ? const Center(child: Text('No products found'))
          : ListView.separated(
        itemCount: filtered.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (_, i) => _tile(context, filtered[i]),
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () => _goAdd(context), child: const Icon(Icons.add)),
    );
  }


  Widget _tile(BuildContext ctx, Product p) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    height: 110,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: p.images.isEmpty
              ? Container(
            width: 80,
            height: 80,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: const Icon(Icons.image, size: 40),
          )
              : Image.file(
            File(p.images.first),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(width: 16),


        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.name,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${p.price}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),


        PopupMenuButton<String>(
          onSelected: (v) {
            if (v == 'edit') _goEdit(ctx, p);
            if (v == 'delete') ctx.read<ProductListViewModel>().remove(p);
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ],
    ),
  );




  Future<void> _goAdd(BuildContext ctx) async {
    final result = await Navigator.push<Product>(
      ctx,
      MaterialPageRoute(builder: (_) => const AddProductPage()),
    );
    if (result != null) ctx.read<ProductListViewModel>().add(result);
  }

  Future<void> _goEdit(BuildContext ctx, Product original) async {
    final result = await Navigator.push<dynamic>(
      ctx,
      MaterialPageRoute(
        builder: (_) => EditProductPage(productData: original.toMap()),
      ),
    );

    if (result is Map && result['delete'] == true) {
      ctx.read<ProductListViewModel>().remove(original);
    } else if (result is Product) {
      ctx.read<ProductListViewModel>().update(original, result);
    }
  }
}
