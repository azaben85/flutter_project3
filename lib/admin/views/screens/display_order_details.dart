import 'package:firebase_app/admin/providers/order_provider.dart';
import 'package:firebase_app/admin/views/screens/add_product.dart';
import 'package:firebase_app/admin/views/screens/widgets/order_line_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayOrderDetails extends StatelessWidget {
  DisplayOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthHelper.authHelper.getLoggedUser();
    return Consumer<OrderProvider>(
      builder: (context, provider, w) {
        return CustomScaffold(
            actions: user != null
                ? [
                    IconButton(
                        onPressed: () {
                          AppRouter.appRouter.push(AddNewProduct());
                        },
                        icon: const Icon(Icons.add)),
                  ]
                : null,
            title: 'تفاصيل الطلبة',
            body: provider.getOrderDetails() == null
                ? const Center(
                    child: Text('لا يوجد طلب'),
                  )
                : ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("طلبية رقم: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(provider.getOrderDetails()?.orderNumber ??
                                  ""),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              children: const [
                                Expanded(
                                    flex: 3,
                                    child: Text("المنتج",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                Expanded(
                                    flex: 2,
                                    child: Text("العدد",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                Expanded(
                                    flex: 2,
                                    child: Text("السعر",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text("السعر الكلي",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ),
                                Expanded(child: Text(''))
                              ],
                            ),
                          ),
                          Container(
                            // margin: const EdgeInsets.only(right: 10, left: 10),
                            height: 200,
                            child: Expanded(
                              child: ListView.builder(
                                itemCount:
                                    provider.getOrderDetails()?.items.length,
                                itemBuilder: (context, index) {
                                  return OrderLineWidget(
                                      provider.getOrderDetails()!.items[index]);
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 2, child: Text("رسوم التوصيل:")),
                                const Expanded(child: Text('')),
                                const Expanded(child: Text('')),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                        '${provider.getOrderDetails()!.shippingAmount}'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 2, child: Text("المجموع: ")),
                                const Expanded(child: Text('')),
                                const Expanded(child: Text('')),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                        '${provider.getOrderDetails()!.totalPrice}'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ));
      },
    );
  }
}
