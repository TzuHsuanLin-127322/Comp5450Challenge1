// TODO: Complete order repository
// TODO: Add Service Injection
import 'package:challenge_1_mobile_store_maker/data/services/order_service.dart';
import 'package:challenge_1_mobile_store_maker/model/base/http_service_result.dart';
import 'package:challenge_1_mobile_store_maker/model/order_list_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';

class OrderRepository {
  final OrderService _orderService;

  OrderRepository({required OrderService orderService}): _orderService = orderService;

  Future<HttpServiceResult<OrderListModel>> fetchOrderList() async {
    return _orderService.fetchOrderList();
  } 

  Future<HttpServiceResult<OrderModel>> createOrder(OrderModel order) async {
    return _orderService.createOrder(order);
  }

  Future<HttpServiceResult<OrderModel?>> fetchOrder(int orderId) async {
    return _orderService.fetchOrder(orderId);
  }

  Future<HttpServiceResult<bool>> updateOrder(int orderId, OrderModel order) async {
    return _orderService.updateOrder(orderId, order);
  }

  Future<HttpServiceResult<bool>> deleteOrder(int orderId) async {
    return _orderService.deleteOrder(orderId);
  }

}