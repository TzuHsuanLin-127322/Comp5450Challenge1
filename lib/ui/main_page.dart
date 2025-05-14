import 'package:challenge_1_mobile_store_maker/ui/products/product_list_page.dart';
import 'package:challenge_1_mobile_store_maker/ui/orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/order_model.dart';
import '../ui/others/search_page.dart';
import '../ui/others/alerts_page.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/settings_drawer.dart';
import 'widgets/menu_sheet.dart';
import 'home_view_model.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    bool isWide = mq.width > 600;
    final vm = context.watch<HomeViewModel>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          /// Search Bar
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

          /// Sales Dashboard
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: DashboardCard(vm: vm),
            ),
          ),
          SizedBox(height: 12),

          /// Messages Panel
          _buildMessagesPanel(vm, context),
          SizedBox(height: 12),

          /// Recently sold products
          _buildProductSummary(vm, context, isWide ? 4 : 2),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

Widget _buildMessagesPanel(HomeViewModel vm, BuildContext context) {
  final pending = vm.ordersByStatus(OrderStatus.pending);
  return Card(
    child: ListTile(
      leading: Icon(Icons.assignment_turned_in),
      title: Text('Orders Summary'),
      subtitle: Text(pending == 0
          ? 'All caught up! No pending orders'
          : 'You have $pending pending orders'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () => Navigator.pushNamed(context, '/orders'),
    ),
  );
}


Widget _buildProductSummary(HomeViewModel vm, BuildContext context, int crossAxisCount) {
  final products = vm.recentlySoldProducts;
  return Column(
    children: [
      /// Products Sold
      Card(
        child: ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Product Summary'),
          subtitle: Text(products.isEmpty
              ? 'No products sold yet'
              : 'Products sold: ${products.length}'),
        ),
      ),
      SizedBox(height: 8),
      /// TODO: Recently Sold Grid
      /*Card(
        child: Column(
          children: [
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
                      crossAxisCount: crossAxisCount,
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
                                    image: AssetImage(p.images[0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
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
      ),*/
    ],
  );
}
