import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:challenge_1_mobile_store_maker/model/customer_info_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';
import 'package:challenge_1_mobile_store_maker/ui/orders/orderDetail/order_detail_view_model.dart';
import 'package:challenge_1_mobile_store_maker/utils/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final viewModel = context.watch<OrderDetailViewModel>();

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
                  Text(
                    'Final Price: ${formatMoney(widget.order?.finalPrice ?? Money(major: 0, minor: 0))}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 8,),
              if (widget.mode != OrderPageMode.create) 
                Text(
                  'Order Status: ${formatOrderStatus(widget.order!.orderStatus)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 8,),
              if (!isReadOnly)
                ElevatedButton(
                  onPressed: () => _saveOrder(viewModel),
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
      ...(widget.order?.cart.productList.map((product) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(children: [
            Text(formatMoney(product.price), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            if(!isReadOnly) IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            if(!isReadOnly) IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
          ],),
        ],
      )).toList() ?? []),
      if (!isReadOnly)
        Row(children: [
          Expanded(child: TextFormField(
            controller: _cartProductController,
            decoration: InputDecoration(labelText: 'Search for Product')
          )),
          IconButton(onPressed: _addCartItem, icon: Icon(Icons.add)),
        ],),
        SizedBox(width: 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Item Subtotal: $cartTotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))
        ],
      ),
    ];
  }

  List<Widget> _buildBillItemsInput(bool isReadOnly) {
    int majorTotal = 0;
    int minorTotal = 0;
    widget.order?.billItemList.forEach((billItem) {
      majorTotal += billItem.price.major;
      minorTotal += billItem.price.minor;
    });
    majorTotal += minorTotal ~/ 100;
    minorTotal = minorTotal % 100;
    final billTotal = formatMoney(Money(major: majorTotal, minor: minorTotal));
    return [
      Text('Bill Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ...(widget.order?.billItemList.map((billItem) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(billItem.itemDescription, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(children: [
            Text(formatMoney(billItem.price), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            if(!isReadOnly) IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            if(!isReadOnly) IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
          ],),
        ],
      )).toList() ?? []),
      if (!isReadOnly)
        Row(children: [
          Expanded(
            flex: 2,
            child: TextFormField(
            controller: _billingDescriptionController,
            decoration: InputDecoration(labelText: 'Bill Item Description')
          )
        ),
        SizedBox(width: 8,),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: _billingPriceController,
            decoration: InputDecoration(labelText: 'Bill Item Price'),
            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
          )
        ),
        SizedBox(width: 8,),
        IconButton(onPressed: _addBillItem, icon: Icon(Icons.add)),
      ],),
      SizedBox(width: 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Bill Subtotal: $billTotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))
        ],
      ),
    ];
  }

  void _saveOrder(OrderDetailViewModel viewModel) async {
    // Collect data, create/update OrderModel, and pop or call callback
    OrderModel order = OrderModel(
      id: widget.order?.id ?? -1,
      customerInfo: CustomerInfoModel(
        name: _customerNameController.text,
        shippingAddress: _mailingAddressController.text,
        phone: _phoneNumberController.text,
      ),
      cart: widget.order?.cart ?? CartModel(productList: [], totalPrice: Money(major: 0, minor: 0)),
      billItemList: widget.order?.billItemList ?? [],
      finalPrice: widget.order?.finalPrice ?? Money(major: 0, minor: 0),
      orderStatus: widget.order?.orderStatus ?? OrderStatus.pending,
      orderTime: widget.order?.orderTime ?? DateTime.now(),
    );

    try {
      if (widget.mode == OrderPageMode.create) {
        await viewModel.createOrder(order);
      } else {
        await viewModel.editOrder(order);
      }
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save order'))
        );
      }
    }
  }

  void _addCartItem() {

  }

  void _addBillItem() {

  }
}
