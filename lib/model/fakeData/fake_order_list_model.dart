import 'package:challenge_1_mobile_store_maker/model/bill_item_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_product_model.dart';
import 'package:challenge_1_mobile_store_maker/model/currency_model.dart';
import 'package:challenge_1_mobile_store_maker/model/customer_info_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_list_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';

final dummyOrderList = OrderListModel([
  OrderModel(
    CustomerInfoModel("John Smith", "243 Some where, somewhere boulevard, 123 454 Ontario, Canada", '+1-553-6334-4125'),
    CartModel(
      [
        CartProductModel(
          ProductModel(),
          1,
          CurrencyModel('\$',12,'.',10)
        )
      ],
      CurrencyModel('\$',12,'.',10)
    ),
    [
      BillItemModel('Processing Fee', CurrencyModel('\$', 1,'.', 0))
    ],
    CurrencyModel('\$', 13,'.', 10), 
    OrderStatus.confirmed
  ),
]);