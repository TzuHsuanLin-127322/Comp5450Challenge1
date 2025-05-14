import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final Cart cart;
  OrdersScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Dark background
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                cart.placeOrder();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order placed!', style: TextStyle(color: Colors.white))),
                );
              },
              child: Text('Place Order'),
            ),
          ),
          Expanded(
            child: cart.orderHistory.isEmpty
                ? Center(
                    child: Text(
                      'No orders placed yet.',
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.orderHistory.length,
                    itemBuilder: (context, index) {
                      final order = cart.orderHistory[index];
                      return Card(
                        color: Colors.grey[900],
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order #${index + 1}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              SizedBox(height: 8),
                              ...order.map((product) => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


class Cart {
  final List<Product> _items = [];
  final List<List<Product>> _orderHistory = [];

  // Add product to cart
  void addProduct(Product product) {
    _items.add(product);
  }

  // Clear cart and move items to order history
  void placeOrder() {
    if (_items.isNotEmpty) {
      _orderHistory.add(List<Product>.from(_items));
      _items.clear();
    }
  }

  // Get current cart items
  List<Product> get items => _items;

  // Get list of all past orders
  List<List<Product>> get orderHistory => _orderHistory;

  // Clear cart manually if needed
  void clearCart() {
    _items.clear();
  }

  // Get total cart value
  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.price);
}
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}