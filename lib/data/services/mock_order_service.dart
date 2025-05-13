import 'dart:async';
import 'package:challenge_1_mobile_store_maker/model/base/http_service_result.dart';
import 'package:challenge_1_mobile_store_maker/model/fakeData/fake_order_list_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_list_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:collection/collection.dart';
import 'order_service.dart';

class FakeOrderService implements OrderService {
  final Duration latency;

  FakeOrderService({this.latency = const Duration(seconds: 2)});

  final OrderListModel _orderList = OrderListModel(orders: dummyOrderList.orders);

  @override
  Future<HttpServiceResult<OrderListModel>> fetchOrderList() async {
    await Future.delayed(latency);
    return HttpServiceResult(statusCode: 200, data: _orderList);
  }

  @override
  Future<HttpServiceResult<OrderModel>> createOrder(OrderModel order) async {
    await Future.delayed(latency);
    OrderModel newOrder = OrderModel( 
      id: _orderList.orders.length + 1,
      customerInfo: order.customerInfo,
      cart: order.cart,
      billItemList: order.billItemList,
      finalPrice: order.finalPrice,
      orderStatus: order.orderStatus
    );
    _orderList.orders.add(newOrder);
    return HttpServiceResult(statusCode: 200, data: newOrder);
  }

  @override
  Future<HttpServiceResult<OrderModel?>> fetchOrder(int orderId) async {
    await Future.delayed(latency);
    OrderModel? order = _orderList.orders.firstWhereOrNull((order) => order.id == orderId);
    if (order == null) {
      return HttpServiceResult(statusCode: 404, message: "Order not found");
    }
    return HttpServiceResult(statusCode: 200, data: order);
  }

  @override
  Future<HttpServiceResult<bool>> updateOrder(int orderId, OrderModel order) async {
    await Future.delayed(latency);
    OrderModel? existingOrder = _orderList.orders.firstWhereOrNull((o) => o.id == orderId);
    if (existingOrder != null) {
      _orderList.orders[_orderList.orders.indexOf(existingOrder)] = OrderModel(
        id: orderId,
        customerInfo: order.customerInfo,
        cart: order.cart,
        billItemList: order.billItemList,
        finalPrice: order.finalPrice,
        orderStatus: order.orderStatus
      );
      return HttpServiceResult(statusCode: 200, data: true);
    }
    return HttpServiceResult(statusCode: 404, data: false);
  }

  @override
  Future<HttpServiceResult<bool>> deleteOrder(int orderId) async {
    await Future.delayed(latency);
    OrderModel? existingOrder = _orderList.orders.firstWhereOrNull((o) => o.id == orderId);
    if (existingOrder != null) {
      _orderList.orders.remove(existingOrder);
      return HttpServiceResult(statusCode: 200, data: true);
    }
    return HttpServiceResult(statusCode: 404, data: false);
  }
}