// TODO: Complete Order View Model
import 'package:challenge_1_mobile_store_maker/data/repository/order_repository.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:challenge_1_mobile_store_maker/utils/api_status.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier{
  final OrderRepository _orderRepository;
  ApiStatus _fetchOrderListStatus = ApiStatus.initial;
  ApiStatus _deleteOrderStatus = ApiStatus.initial;
  ApiStatus _updateOrderStatus = ApiStatus.initial;
  
  List<OrderModel> _orderList = List.empty();

  OrdersViewModel({
    required OrderRepository orderRepository,
  }): _orderRepository = orderRepository{
    fetchOrderList();
  }

  // TODO: Initialization function -> Get order repository list
  void fetchOrderList() {
    _fetchOrderListStatus = ApiStatus.loading;
    _orderRepository.fetchOrderList().then((orderList) {
      _orderList = orderList.data?.orders ?? [];
      _fetchOrderListStatus = ApiStatus.success;
      notifyListeners();  
    }).catchError((error) {
      _fetchOrderListStatus = ApiStatus.error;
      notifyListeners();
    });
  }

  // TODO: On ordelete pressed
  void onOrderDeletePress(int orderId) {
    _deleteOrderStatus = ApiStatus.loading;
    _orderRepository.deleteOrder(orderId).then((result) {
      if (result.statusCode == 200) {
        _deleteOrderStatus = ApiStatus.success;
      } else {
        _deleteOrderStatus = ApiStatus.error;
      }
      fetchOrderList();
      notifyListeners();
    });
  }


  // TODO: on order status changed
  void onOrderStatusChange(int orderId, OrderStatus newStatus) {
    _updateOrderStatus = ApiStatus.loading;
    OrderModel model = _orderList.firstWhere((element) => element.id == orderId);
    OrderModel newModel = OrderModel(
      id: model.id,
      customerInfo: model.customerInfo,
      cart: model.cart,
      billItemList: model.billItemList,
      finalPrice: model.finalPrice,
      orderStatus: newStatus,
      orderTime: model.orderTime,
    );
    _orderRepository.updateOrder(model.id, newModel).then((result) {
      if (result.statusCode == 200) {
        _updateOrderStatus = ApiStatus.success;
      } else {
        _updateOrderStatus = ApiStatus.error;
      }
      fetchOrderList();
      notifyListeners();
    });
  }

  List<OrderModel> get orderList => _orderList;
  ApiStatus get fetchOrderListStatus => _fetchOrderListStatus;
  ApiStatus get deleteOrderStatus => _deleteOrderStatus;
  ApiStatus get updateOrderStatus => _updateOrderStatus;
}
