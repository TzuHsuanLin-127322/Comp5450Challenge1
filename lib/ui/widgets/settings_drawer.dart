import 'package:flutter/material.dart';
import '../../ui/others/add_store_page.dart';

class SettingsDrawer extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        SizedBox(height: 40),
        Container(
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              CircleAvatar(backgroundColor: Colors.green, child: Text('M', style: TextStyle(color: Colors.white))),
              SizedBox(width: 8),
              Text('MyStore', style: TextStyle(fontSize: 20)),
            ]),
            Icon(Icons.more_vert),
          ]),
        ),
        Spacer(),
        Column(children: [
          ListTile(title: Text('Account Settings')),
          ListTile(title: Text('Add Store'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddStorePage()))),
          ListTile(title: Text('Help Center')),
          ListTile(title: Text('Settings')),
        ]),
      ]),
    );
  }
}
