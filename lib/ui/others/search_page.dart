import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Column(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.all(16),
              child: Row(children: [
                Icon(Icons.arrow_back, color: Colors.grey),
                SizedBox(width: 8),
                Text('Search', style: TextStyle(color: Colors.grey))
              ]),
            ),
          ),
          Expanded(
            child: Center(child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No recent searches',
                      style: TextStyle(color: Colors.grey))
                ])),
          ),
        ]),
      ),
    );
  }
}
