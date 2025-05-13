import 'package:challenge_1_mobile_store_maker/ui/order/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        body: Center(
          child: Text("Order List Page "))
      )
    );
  }
}