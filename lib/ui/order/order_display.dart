import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_product_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/ui/order/order_view_model.dart';
import 'package:challenge_1_mobile_store_maker/utils/api_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: COMPLETE Order Display

class OrderDisplay extends StatelessWidget {
  const OrderDisplay({super.key});

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
    final OrderViewModel viewModel = context.watch();
    return (
      Scaffold(
        appBar: _makeAppBar(context, viewModel),
        body: _makeContentWidget(context, viewModel),
        floatingActionButton: _makeFloatingActionButton(context, viewModel),
      )
    );
  }

  PreferredSizeWidget _makeAppBar(BuildContext context, OrderViewModel viewModel) {
    return AppBar(
      title: Text("Order List"),
    );
  }

  Widget _makeContentWidget(BuildContext context, OrderViewModel viewModel) {
    if (viewModel.orderList.isEmpty && viewModel.fetchOrderListStatus == ApiStatus.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.orderList.isEmpty) {
      return Center(child: Text("Order List empty"));
    }

    return RefreshIndicator(
      onRefresh: () async {
        viewModel.fetchOrderList();
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
                          Text("Order ID: ${order.id}"),
                          Text("Order For: ${order.customerInfo.name}"),
                          Text("Total Price: ${order.finalPrice.symbol}${order.finalPrice.major}${order.finalPrice.decimalSymbol}${order.finalPrice.minor}"),
                          Text("Status: ${order.orderStatus.name}"),
                        ],
                      )
                    ),
                    Expanded(
                      child: Row(
                        children: cartProducts.map((product) {
                              // TODO: Add product Photos
                              return (Center());
                              },
                          ).toList()
                      )
                    ),
                    Expanded(child: Column(
                      children: [
                        MaterialButton(
                          child: Text("Edit Order"),
                          onPressed: () => {
                            // TODO: Push edit order page
                          },
                        ),
                        MaterialButton(
                          child: Text("Change Order Status"),
                          onPressed: () => {
                            // TODO: Change order status modal
                          },
                        ),
                        MaterialButton(
                          child: Text("Remove Order"),
                          onPressed: () => {
                            // TODO: Remove order modal
                          },
                        )
                      ],
                    ))
                  ],
                ),
              )
            );
          }
        ) ,
      ),
    );
  }

  Widget _makeFloatingActionButton(BuildContext context, OrderViewModel viewModel) {
    return FloatingActionButton(
      onPressed: () {
        // TODO: Push add to order page
      },
      child: Icon(Icons.add),
    );
  }
}