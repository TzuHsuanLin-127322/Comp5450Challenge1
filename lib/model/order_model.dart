import 'package:challenge_1_mobile_store_maker/model/bill_item_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:challenge_1_mobile_store_maker/model/currency_model.dart';
import 'package:challenge_1_mobile_store_maker/model/customer_info_model.dart';

class OrderModel {
  final CustomerInfoModel customerInfo;
  final CartModel cart;
  final List<BillItemModel> billItemList;
  final CurrencyModel finalPrice;

  OrderModel(this.customerInfo, this.cart, this.billItemList, this.finalPrice);
}
