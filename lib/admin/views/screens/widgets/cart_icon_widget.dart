import 'package:firebase_app/admin/providers/order_provider.dart';
import 'package:firebase_app/admin/views/screens/display_order_details.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, w) {
      return InkWell(
        onTap: () {
          AppRouter.appRouter.push(DisplayOrderDetails());
        },
        child: SizedBox(
          child: Container(
            width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shopping_cart, size: 30.0),
                Positioned(
                  left: 1.5,
                  bottom: 1.5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.brightness_1,
                          size: 25.0,
                          color: Colors.red), // Red circle as a background
                      Text(
                        orderProvider.getCartCount(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ), // Display the item count
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
