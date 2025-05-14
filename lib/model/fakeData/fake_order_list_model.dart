import 'package:challenge_1_mobile_store_maker/model/bill_item_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_model.dart';
import 'package:challenge_1_mobile_store_maker/model/cart_product_model.dart';
import 'package:challenge_1_mobile_store_maker/model/customer_info_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_list_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import '../../pages/product_model.dart';

final dummyOrderList = OrderListModel(
  orders: [
    OrderModel(
      id: 1,
      customerInfo: CustomerInfoModel(
        name: "John Smith", 
        shippingAddress: "243 Some where, somewhere boulevard, 123 454 Ontario, Canada",
        phone: '+1-553-6334-4125'
      ),
      cart: CartModel(
        productList: [
          CartProductModel(
            product: Product(
              id: '',
              name: 'Juice Blender',
              price: Money(major: 69, minor: 99),
              comparePrice: Money(major: 89, minor: 99),
              images: [
                'https://i.imgur.com/FGrQZOA.png',
              ],
            ),
            qty: 1,
            price: Money(
              major: 12,
              minor: 10
            )
          )
        ],
        totalPrice: Money(
          major: 12,
          minor: 10
        )
      ),
      billItemList: [
        BillItemModel(
          itemDescription: 'Processing Fee',
          price: Money(
            major: 1,
            minor: 0
          )
        )
      ],
      finalPrice: Money(
        major: 13,
        minor: 10
      ),
      orderStatus: OrderStatus.confirmed
    ),
  ]
);
