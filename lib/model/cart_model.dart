import 'dart:core';
import 'package:challenge_1_mobile_store_maker/model/cart_product_model.dart';
import 'package:challenge_1_mobile_store_maker/pages/product_model.dart';

class CartModel {
  final List<CartProductModel> productList;
  final Money totalPrice;

  CartModel({required this.productList, required this.totalPrice});
}
