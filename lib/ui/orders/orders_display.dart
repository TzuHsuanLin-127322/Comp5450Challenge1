import 'package:challenge_1_mobile_store_maker/model/cart_product_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/ui/orders/orderDetail/order_detail_page.dart';
import 'package:challenge_1_mobile_store_maker/ui/orders/orders_view_model.dart';
import 'package:challenge_1_mobile_store_maker/utils/api_status.dart';
import 'package:challenge_1_mobile_store_maker/utils/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: COMPLETE Order Display

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Order View Model

    /**
     * Displays
     * - Ordel list has order ? List of Orders : Display Empty
     * - Order items views:
     *  - Delete Order
     *  - Change order status
     *  - Edit Order
     * - FAB: Add order button -> Navigate to add order when pressed
     */
    final OrdersViewModel viewModel = context.watch();
    return (Scaffold(
      appBar: _makeAppBar(context, viewModel),
      body: _makeContentWidget(context, viewModel),
      floatingActionButton: _makeFloatingActionButton(context, viewModel),
    ));
  }

  PreferredSizeWidget _makeAppBar(
    BuildContext context,
    OrdersViewModel viewModel,
  ) {
    return AppBar(title: Text("Order List"));
  }

  Widget _makeContentWidget(BuildContext context, OrdersViewModel viewModel) {
    if (viewModel.fetchOrderListStatus == ApiStatus.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.orderList.isEmpty) {
      return Center(child: Text("Order List empty"));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.fetchOrderList();
      },

      child: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: viewModel.orderList.length,
          itemBuilder: (context, index) {
            OrderModel order = viewModel.orderList[index];
            List<CartProductModel> cartProducts = order.cart.productList;
            return Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order #: ${order.id}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "For: ${order.customerInfo.name}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Total Price: ${formatMoney(order.finalPrice)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Status: ${formatOrderStatus(order.orderStatus)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children:
                            cartProducts.map((product) {
                              // TODO: Add product Photos
                              return (Center());
                            }).toList(),
                      ),
                    ),
                    Column(
                      children: [
                          IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                          padding: EdgeInsets.all(0),
                        ),
                        IconButton(
                          onPressed: () => _buildChangeOrderStatusModal(context, index, viewModel),
                          icon: Icon(Icons.change_circle),
                          padding: EdgeInsets.all(0),
                        ),

                        IconButton(
                          onPressed: () => _buildRemoveOrderModal(context, index, viewModel),
                          icon: Icon(Icons.delete),
                          padding: EdgeInsets.all(0),
                          constraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
                          color: Colors.red[800],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _makeFloatingActionButton(
    BuildContext context,
    OrdersViewModel viewModel,
  ) {
    return FloatingActionButton(
      onPressed: () {
        // TODO: Push add to order page as bottom sheet
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailPage()));
      },
      child: Icon(Icons.add),
    );
  }

  Future<void> _buildRemoveOrderModal(
    BuildContext context,
    int index,
    OrdersViewModel viewModel,
  ) {
    final order = viewModel.orderList[index];
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            // TODO: Add the modal content, when click yes, remove the order
            title: Text("Confirm Remove Order"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are you sure you want to remove the following order?\n"),
                Text("Order ID: ${order.id}"),
                Text("Order For: ${order.customerInfo.name}"),
                Text("Total Price: ${formatMoney(order.finalPrice)}"),
              ],),
              actions: [
                TextButton(
                  onPressed: () {
                    // TODO: Remove the order
                    viewModel.onOrderDeletePress(order.id);
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes"),
                ),  
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"),
                ),
              ],
          ),
    );
  }

  Future<void> _buildChangeOrderStatusModal(
    BuildContext context,
    int index,
    OrdersViewModel viewModel,
  ) {
    OrderModel order = viewModel.orderList[index];
    OrderStatus selectedStatus = viewModel.orderList[index].orderStatus;
    // TODO Create the modal
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          // TODO: Add the modal content, show radio chips, when click yes, change the order status
          title: Text("Change Order Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select the new status for the order"),
              Wrap(
                spacing: 8,
                children: OrderStatus.values.map((status) {
                  return ChoiceChip(
                    label: Text(formatOrderStatus(status)),
                    selected: selectedStatus == status,
                    onSelected: (selected) {
                      if (selected) {
                        setState((){
                          selectedStatus = status;
                        });
                      }
                    },
                  );
                }).toList(),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // TODO: Change order Status
                viewModel.onOrderStatusChange(order.id, selectedStatus);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Close without changing anything
              },
              child: Text('No'),
            )
          ]
        );
      })
    );
  }
}
