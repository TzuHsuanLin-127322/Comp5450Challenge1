import 'package:challenge_1_mobile_store_maker/model/bill_item_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:challenge_1_mobile_store_maker/model/customer_info_model.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';

class OrderModel {
  final int id;
  final CustomerInfoModel customerInfo;
  final CartModel cart;
  final List<BillItemModel> billItemList;
  final Money finalPrice;
  final OrderStatus orderStatus;
  OrderModel({this.id = -1, required this.customerInfo, required this.cart, required this.billItemList, required this.finalPrice, required this.orderStatus});
}

enum OrderStatus {pending, confirmed, paymentConfirmed, shipped, complete}