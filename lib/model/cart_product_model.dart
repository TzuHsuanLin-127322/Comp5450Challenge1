// TODO: Complete Cart Product Model
import 'package:challenge_1_mobile_store_maker/model/currency_model.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';

class CartProductModel {
  final ProductModel product;
  final int qty;
  final CurrencyModel price;

  CartProductModel({required this.product, required this.qty, required this.price});
}
