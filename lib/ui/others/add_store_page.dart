import 'package:flutter/material.dart';

class AddStorePage extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Add Store'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.add))
          ],
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, size: 64),
                  SizedBox(height: 16),
                  Text('Create your online store',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Experiment with different designs and products until you learn what works.',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 16),
                  SizedBox(width: double.infinity,
                      child: OutlinedButton(onPressed: () {},
                          child: Text('Create New Store', style: TextStyle(fontWeight: FontWeight.bold)))),
                  SizedBox(height: 8),
                  SizedBox(width: double.infinity,
                      child: OutlinedButton(onPressed: () {},
                          child: Text('Learn More')))
                ])));
  }
}
