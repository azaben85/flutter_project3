import 'package:firebase_app/admin/models/order.dart';
import 'package:firebase_app/admin/providers/order_provider.dart';
import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/admin/views/screens/widgets/order_line_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayOrderDetails extends StatelessWidget {
  DisplayOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthHelper.authHelper.getLoggedUser();
    return Consumer<OrderProvider>(
      builder: (context, provider, w) {
        return CustomScaffold(
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
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                provider.cancelOrder();
                              },
                              child: const Text('الغاء الطلب'),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                goToWhatsUp(provider.getOrderDetails()!,
                                    provider.settings?.whatsappNumber ?? "");
                                provider.cancelOrder();
                                AppRouter.appRouter
                                    .pushReplacementAll(AllCategoriesScreen());
                                AppRouter.appRouter.pop();
                              },
                              child: const Text('تأكيد الطلب'),
                            ),
                          )
                        ],
                      )
                    ],
                  ));
      },
    );
  }

  goToWhatsUp(OrderModel order, String whatsappNumber) async {
    String message = '''
    طلبية جديدة رقم: ${order.orderNumber}
    المنتجات التالية:
    ''';
    order.items.forEach((element) {
      message = message +
          '''
    ${element.lineNumber} - ${element.nameEn} عدد (${element.quantity})
    ''';
    });
    message = message +
        '''
    بمجموع ${order.totalPrice} شامل ${order.shippingAmount} شيكل توصيل
    ''';

    int numberWhats = int.parse(whatsappNumber);
    String url =
        "whatsapp://send?phone=+${numberWhats}&text=${Uri.encodeFull(message)}";
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
