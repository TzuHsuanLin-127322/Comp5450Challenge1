import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alerts')),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('Your alerts will show here',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 8),
            Text('You\'ll get important alerts about your store and account here and through your email.',
                textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
