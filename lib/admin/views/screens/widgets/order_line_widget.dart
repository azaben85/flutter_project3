import 'package:firebase_app/admin/providers/order_provider.dart';
import 'package:flutter/material.dart';

import 'package:firebase_app/admin/models/order_item.dart';
import 'package:provider/provider.dart';

class OrderLineWidget extends StatelessWidget {
  OrderItem item;
  OrderLineWidget(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, provider, w) {
      return Row(
        children: [
          Expanded(flex: 3, child: Text(item.nameEn)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      provider.decreaseItemQTY(item);
                    },
                    child: const Icon(
                      Icons.remove,
                      size: 12,
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    '${item.quantity}',
                  ),
                ),
                InkWell(
                    onTap: () {
                      provider.increaseItemQTY(item);
                    },
                    child: const Icon(
                      Icons.add,
                      size: 12,
                    )),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text('${item.price}')),
          Expanded(
              flex: 2,
              child: Center(child: Text('${item.price * item.quantity}'))),
          Expanded(
            child: InkWell(
                onTap: () {
                  provider.removeItem(item);
                },
                child: const Icon(Icons.delete_forever)),
          ),
        ],
      );
    });
  }
}
