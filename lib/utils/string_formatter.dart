import 'package:challenge_1_mobile_store_maker/model/currency_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';

String formatMoney(CurrencyModel price) {
  return "${price.symbol}${price.major}${price.decimalSymbol}${price.minor}";
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
