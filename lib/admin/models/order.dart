import 'dart:convert';

import 'package:firebase_app/admin/models/order_item.dart';

class OrderModel {
  String orderNumber;
  num shippingAmount = 10;
  num totalPrice = 10;
  List<OrderItem> items = [];
  OrderModel(this.orderNumber);
}
