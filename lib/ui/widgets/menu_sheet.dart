import 'package:flutter/material.dart';

class MenuSheet extends StatelessWidget {
  final List<String> items = [
    'Customers', 'Finance', 'Analytics', 'Marketing', 'Discounts', 'Settings', 'Online Store'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((e) => ListTile(
          title: Text(e),
          onTap: () {
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
  }
}
