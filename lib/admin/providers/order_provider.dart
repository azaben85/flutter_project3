import 'package:firebase_app/admin/models/commerce_settings.dart';
import 'package:firebase_app/admin/models/order.dart';
import 'package:firebase_app/admin/models/order_item.dart';
import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/data_repository/firestore_helper.dart';
import 'package:firebase_app/data_repository/order_helper.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider() {
    getCommerceSettings();
  }

  CommerceSettingsModel? settings;

  getCommerceSettings() async {
    settings = await FirestorHelper.firestorHelper.getCommerceSettings();
    OrderHelper.orderHelper.setShipping(settings!.shippingValue ?? 5);
  }

  OrderModel? getOrderDetails() {
    return OrderHelper.orderHelper.order;
  }

  String getCartCount() {
    int count = 0;
    if (OrderHelper.orderHelper.order != null) {
      OrderHelper.orderHelper.order?.items.forEach((e) => count += e.quantity);
    }
    return '$count';
  }

  cancelOrder() {
    OrderHelper.orderHelper.cancelOrder();
    notifyListeners();
  }

  addItem(Product product, String catName) {
    int lineNum = OrderHelper.orderHelper.getLineNumber();
    OrderItem item = OrderItem(
        lineNumber: lineNum,
        itemId: product.id,
        catName: catName,
        nameEn: product.nameEn,
        descEn: product.descEn,
        imageUrl: product.imageUrl,
        quantity: 1,
        price: product.price);
    OrderHelper.orderHelper.addItem(item);
    notifyListeners();
  }

  increaseItemQTY(OrderItem item) {
    OrderHelper.orderHelper.addItem(item);
    notifyListeners();
  }

  removeItem(OrderItem item) {
    OrderHelper.orderHelper.removeItem(item);
    notifyListeners();
  }

  decreaseItemQTY(OrderItem item) {
    OrderHelper.orderHelper.decreaseItemQTY(item);
    notifyListeners();
  }
}
