import 'package:challenge_1_mobile_store_maker/pages/product_list_page.dart';
import 'package:challenge_1_mobile_store_maker/ui/orders/orders_display.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


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


// Home Page
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
              onTap: () => Navigator.pushNamed(context, '/orders'),
            ),
          ),
          SizedBox(height: 12),

          // Summary of products and orders
          Card(
            child: Column(
              children: [
                /*ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Product Summary'),
                  subtitle: Text('Products: ${products.length}'),
                ),
                Divider(),*/

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
                          onTap: () => Navigator.pushNamed(context, '/products'),
                          child: Card(
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


// Dashboard Card with bar chart
class DashboardCard extends StatefulWidget {
  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  String selected = 'Today';
  final List<String> filters = ['Today', 'Yesterday', 'This Week', 'This Month'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) => Padding(
              padding: EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(f),
                selected: selected == f,
                onSelected: (_) => setState(() => selected = f),
              ),
            )).toList(),
          ),
        ),
        SizedBox(height: 16),

        // Summary Text
        Column(
          children: [
            Text('Total Sales: \$5,000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Orders: 50', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 16),

        // Bar Chart
        SizedBox(
          height: 150,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(7, (i) => BarChartGroupData(
                x: i,
                barRods: [BarChartRodData(toY: (i + 1) * 10)],
              )),
            ),
          ),
        ),
        SizedBox(height: 16),

        // View Dashboard Button
        Container(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            child: Text('View Dashboard', style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}

// Other pages:

// Settings Drawer
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
          ListTile(title: Text('Add Store'), onTap: () => Navigator.pushNamed(context, '/addStore')),
          ListTile(title: Text('Help Center')),
          ListTile(title: Text('Settings')),
        ]),
      ]),
    );
  }
}

// Add Store Page in the drawer
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
                          child: Text('Create New Store'))),
                  SizedBox(height: 8),
                  SizedBox(width: double.infinity,
                      child: OutlinedButton(onPressed: () {},
                          child: Text('Learn More', style: TextStyle(fontWeight: FontWeight.bold))))
                ])));
  }
}

// Alerts Page
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


// Search Page
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


// MenuSheet with items
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


// Dashboard Page
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(child: Text('Dashboard Page')),
    );
  }
}
