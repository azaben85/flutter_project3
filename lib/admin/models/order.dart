import 'dart:convert';

import 'package:firebase_app/admin/models/order_item.dart';

class OrderModel {
  String orderNumber;
  num shippingAmount = 5;
  num totalPrice = 5;
  List<OrderItem> items = [];
  OrderModel(this.orderNumber);
}
