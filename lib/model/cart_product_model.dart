// TODO: Complete Cart Product Model
import 'product_model.dart';

class CartProductModel {
  final Product product;
  final int qty;
  final Money price;

  CartProductModel({required this.product, required this.qty, required this.price});
}
