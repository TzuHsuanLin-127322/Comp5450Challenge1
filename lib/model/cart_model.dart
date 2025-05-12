import 'dart:core';
import 'package:challenge_1_mobile_store_maker/model/cart_product_model.dart';
import 'package:challenge_1_mobile_store_maker/model/currency_model.dart';

class CartModel {
  final List<CartProductModel> productList;
  final CurrencyModel totalPrice;

  CartModel(this.productList, this.totalPrice);
}
