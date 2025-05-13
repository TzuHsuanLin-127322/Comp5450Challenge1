// product_list_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_model.dart';
import 'product_list_view_model.dart';
import 'add_product_page.dart';
import 'edit_product_page.dart';

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

    /* ---------- 空列表 ---------- */
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

    /* ---------- 有数据 ---------- */
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

  /* ---------- 列表项 ---------- */
  Widget _tile(BuildContext ctx, Product p) => ListTile(
    leading: p.images.isEmpty
        ? const Icon(Icons.image)
        : Image.file(File(p.images.first),
        width: 56, height: 56, fit: BoxFit.cover),
    title: Text(p.name),
    subtitle: Text('\$${p.price}'),
    trailing: PopupMenuButton<String>(
      onSelected: (v) {
        if (v == 'edit') _goEdit(ctx, p);
        if (v == 'delete') ctx.read<ProductListViewModel>().remove(p);
      },
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'edit', child: Text('Edit')),
        PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    ),
  );

  /* ---------- 导航 ---------- */
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
