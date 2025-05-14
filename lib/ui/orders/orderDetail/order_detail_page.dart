import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:flutter/material.dart';

enum OrderPageMode { create, edit, display }

class OrderDetailPage extends StatefulWidget {
  final OrderModel? order;
  final OrderPageMode mode;

  const OrderDetailPage({
    Key? key,
    this.order,
    this.mode = OrderPageMode.create,
  }) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late TextEditingController _customerNameController;
  late TextEditingController _mailingAddressController;
  late TextEditingController _phoneNumberController;
  // ... other controllers

  @override
  void initState() {
    super.initState();
    // Initialize controllers with widget.order values if editing/displaying
    _customerNameController = TextEditingController(
      text: widget.order?.customerInfo.name ?? '',
    );
    _mailingAddressController = TextEditingController(
      text: widget.order?.customerInfo.shippingAddress ?? '',
    );
    _phoneNumberController = TextEditingController(
      text: widget.order?.customerInfo.phone ?? '',
    );
    // ... other controllers
  }

  @override
  Widget build(BuildContext context) {
    final isReadOnly = widget.mode == OrderPageMode.display;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == OrderPageMode.create
            ? 'Create Order'
            : widget.mode == OrderPageMode.edit
                ? 'Edit Order'
                : 'Order Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Customer Information'),
            TextFormField(
              controller: _customerNameController,
              enabled: !isReadOnly,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            TextFormField(
              controller: _mailingAddressController,
              enabled: !isReadOnly,
              decoration: InputDecoration(labelText: 'Mailing Address'),
            ),  
            TextFormField(
              controller: _phoneNumberController,
              enabled: !isReadOnly,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),  
            Text('Cart Items'),
            ...(widget.order?.cart.productList.map((product) => Text('Product')).toList() ?? []),
            Text('Bill Items'),
            ...(widget.order?.billItemList.map((billItem) => Text('Bill Item')).toList() ?? []),
            Text('Final Price'),
            Text(widget.order?.finalPrice.toString() ?? ''),
            // ... other fields
            if (!isReadOnly)
              ElevatedButton(
                onPressed: _saveOrder,
                child: Text(widget.mode == OrderPageMode.create ? 'Create' : 'Save'),
              ),
          ],
        ),
      ),
    );
  }

  void _saveOrder() {
    // Collect data, create/update OrderModel, and pop or call callback
  }
}
