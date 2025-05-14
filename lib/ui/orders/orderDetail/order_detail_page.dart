import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/pages/product_model.dart';
import 'package:challenge_1_mobile_store_maker/utils/string_formatter.dart';
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
  late TextEditingController _cartProductController;
  late TextEditingController _billingDescriptionController;
  late TextEditingController _billingPriceController;
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
    _cartProductController = TextEditingController(
      text: ''
    );
    _billingDescriptionController = TextEditingController(
      text: ''
    );
    _billingPriceController = TextEditingController(
      text: ''
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
        child: Form(
          child: ListView(
            children: [
              ..._buildCustomerInformationInput(isReadOnly),
              SizedBox(height: 8,),
              ..._buildCartItemsInput(isReadOnly),
              SizedBox(height: 8,),
              ..._buildBillItemsInput(isReadOnly),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Final Price: ${formatMoney(widget.order?.finalPrice ?? Money(major: 0, minor: 0))}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 8,),
              if (!isReadOnly)
                ElevatedButton(
                  onPressed: _saveOrder,
                  child: Text(widget.mode == OrderPageMode.create ? 'Create' : 'Save'),
                ),
            ],
          ),
        )
        
      ),
    );
  }

  List<Widget> _buildCustomerInformationInput(bool isReadOnly) {
    return [
      Text('Customer Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            TextFormField(
              controller: _customerNameController,
              enabled: !isReadOnly,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: _mailingAddressController,
              enabled: !isReadOnly,
              decoration: InputDecoration(labelText: 'Mailing Address'),
            ),  
            SizedBox(height: 8,),
            TextFormField(
              controller: _phoneNumberController,
              enabled: !isReadOnly,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
    ];
  }

  List<Widget> _buildCartItemsInput(bool isReadOnly) {
    final cartTotal = formatMoney(widget.order?.cart.totalPrice ?? Money(major: 0, minor: 0));
    return [
      Text('Cart Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ...(widget.order?.cart.productList.map((product) => Text('Product')).toList() ?? []),
      if (!isReadOnly)
        Row(children: [
          Expanded(child: TextFormField(controller: _cartProductController)),
          IconButton(onPressed: _addCartItem, icon: Icon(Icons.add)),
        ],),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Item Subtotal: $cartTotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))
        ],
      ),
    ];
  }

  List<Widget> _buildBillItemsInput(bool isReadOnly) {
    final minorTotal = widget.order?.billItemList.fold<int>(0, (total, billItem) => total + billItem.price.minor) ?? 0;
    final billTotal = formatMoney(Money(major: minorTotal ~/ 100, minor: minorTotal % 100));
    return [
      Text('Bill Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ...(widget.order?.billItemList.map((billItem) => Text('Bill Item')).toList() ?? []),
      Row(children: [
        Expanded(
          flex: 2, child: TextFormField(controller: _billingDescriptionController)
        ),
        Expanded(
          flex: 1, child: TextFormField(controller: _billingPriceController)
          ),
        IconButton(onPressed: _addBillItem, icon: Icon(Icons.add)),
      ],),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Bill Subtotal: $billTotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))
        ],
      ),
    ];
  }

  void _saveOrder() {
    // Collect data, create/update OrderModel, and pop or call callback
  }

  void _addCartItem() {

  }

  void _addBillItem() {

  }
}
