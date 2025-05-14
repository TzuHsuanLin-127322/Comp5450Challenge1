import 'package:challenge_1_mobile_store_maker/model/currency_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/pages/product_model.dart';

String formatCurrency(CurrencyModel price) {
  return "${price.symbol}${price.major}${price.decimalSymbol}${price.minor}";
}

String formatMoney(Money price) {
  return "\$${price.major}.${price.minor.toString().padLeft(2, '0')}";
}

String formatOrderStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return "Pending";
    case OrderStatus.confirmed:
      return "Confirmed";
    case OrderStatus.paymentConfirmed:
      return "Payment Confirmed";
    case OrderStatus.shipped:
      return "Shipped";
    case OrderStatus.complete:
      return "Complete";
  }
}
