import 'package:challenge_1_mobile_store_maker/pages/product_list_page.dart';
import 'package:challenge_1_mobile_store_maker/ui/orders/orders_display.dart';
import 'package:flutter/material.dart';
import '../ui/others/search_page.dart';
import '../ui/others/alerts_page.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/settings_drawer.dart';
import 'widgets/menu_sheet.dart';

// Temporary product model
class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({required this.id, required this.title, required this.price, required this.imageUrl});
}

final List<Product> products = List.generate(
  10,
      (i) => Product(
    id: 'p\$i',
    title: 'Product \$i',
    price: 10.0 + i,
    imageUrl:'assets/images/placeholder.jpg',
  ),
);



// Main Page
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

// State for MainPage
class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final _tabs = [HomePage(), OrdersPage(), ProductListPage()];

  void _openMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black54,
      builder: (_) => MenuSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SettingsDrawer(),
      drawerScrimColor: Colors.black54,
      appBar: _currentIndex == 0
          ? buildHomeAppBar(
        'MyStore',
            () => _scaffoldKey.currentState?.openDrawer(),
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => AlertsPage())),
      )
          : null,
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: (i) {
          if (i == 3) {
            _openMenu();
          } else {
            setState(() => _currentIndex = i);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            activeIcon: Icon(Icons.assignment_turned_in),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell_outlined),
            activeIcon: Icon(Icons.sell),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menus',
          ),
        ],
      ),
    );
  }
}


// AppBar
AppBar buildHomeAppBar(String storeName, VoidCallback onSettingsTap, VoidCallback onAlertsTap) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Padding(
      padding: EdgeInsets.all(6), // add padding and make smaller
      child: GestureDetector(
        onTap: onSettingsTap,
        child: CircleAvatar(
          backgroundColor: Colors.green,
          radius: 16,
          child: Text(storeName[0], style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    ),
    title: Text(storeName, style: TextStyle(color: Colors.black)),
    centerTitle: false,
    actions: [
      IconButton(
        icon: Icon(Icons.notifications_outlined, color: Colors.black),
        onPressed: onAlertsTap,
      ),
    ],
  );
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int ordersCount = 5; // sample data
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          // Search Bar
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage())),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Search', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          // Sales Dashboard
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: DashboardCard(),
            ),
          ),
          SizedBox(height: 12),

          // Messages Panel
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment_turned_in),
              title: Text('Orders to fulfill'),
              subtitle: Text(ordersCount == 0
                  ? 'All caught up! No pending orders'
                  : 'You have $ordersCount pending orders'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, '/orders'),
            ),
          ),
          SizedBox(height: 12),

          // Summary of products and orders
          Card(
            child: Column(
              children: [
                // Recently sold products GridView:
                Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Recently Sold'),
                        subtitle: Text('Last 30 days'),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: products.length,
                        itemBuilder: (_, i) {
                          final p = products[i];
                          return GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/products'),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                      image: DecorationImage(
                                        image: AssetImage(p.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(p.title[0], style: TextStyle(color: Colors.black, fontSize: 40)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      Text('\$${p.price}', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}