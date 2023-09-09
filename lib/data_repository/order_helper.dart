import 'dart:developer';

import 'package:firebase_app/admin/models/order.dart';
import 'package:firebase_app/admin/models/order_item.dart';

class OrderHelper {
  OrderHelper._();
  static OrderHelper orderHelper = OrderHelper._();

  OrderModel? order;
  int lineNumber = 0;
  createNewOrder() {
    order = OrderModel(getCurrentTime());
    lineNumber = 0;
  }

  int getLineNumber() {
    lineNumber++;
    return lineNumber;
  }

  addItem(OrderItem item) {
    if (order == null) {
      createNewOrder();
    }
    order!.totalPrice += item.price;
    bool existedLine = false;
    if (order!.items.isNotEmpty) {
      if (order!.items
          .where((element) => element.itemId == item.itemId)
          .isNotEmpty) {
        OrderItem? existedItem = order!.items
            .singleWhere((element) => element.itemId == item.itemId);

        existedItem.quantity++;
        existedLine = true;
      }
    }
    if (!existedLine) {
      order!.items.add(item);
    }
  }

  removeItem(OrderItem item) {
    if (order == null) {
      createNewOrder();
    }
    order!.totalPrice -= (item.price * item.quantity);
    int i = order!.items.indexOf(item);
    log('$i');
    order!.items.removeAt(i);
  }

  decreaseItemQTY(OrderItem item) {
    if (order == null) {
      createNewOrder();
    }
    int i = order!.items.indexOf(item);
    if (order!.items.elementAt(i).quantity > 1) {
      order!.totalPrice -= item.price;
      order!.items.elementAt(i).quantity--;
    } else {
      removeItem(item);
    }
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String year =
        now.year.toString().substring(2); // Get the last two digits of the year
    String month =
        now.month.toString().padLeft(2, '0'); // Ensure two-digit month
    String day = now.day.toString().padLeft(2, '0'); // Ensure two-digit day
    String hour = now.hour.toString().padLeft(2, '0'); // Ensure two-digit hour
    String minute =
        now.minute.toString().padLeft(2, '0'); // Ensure two-digit minute
    String second =
        now.second.toString().padLeft(2, '0'); // Ensure two-digit second

    return '$year$month$day$hour$minute$second';
  }
}
