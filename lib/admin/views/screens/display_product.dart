import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/add_product.dart';
import 'package:firebase_app/admin/views/screens/widgets/cart_icon_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/product_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayProducts extends StatelessWidget {
  DisplayProducts({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthHelper.authHelper.getLoggedUser();
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, w) {
        return CustomScaffold(
            actions: user != null
                ? [
                    CartIcon(),
                    IconButton(
                        onPressed: () {
                          AppRouter.appRouter.push(AddNewProduct());
                        },
                        icon: const Icon(Icons.add)),
                  ]
                : [CartIcon()],
            title: 'المنتجات',
            body: adminProvider.allProducts == null
                ? const Center(
                    child: Text('لا يوجد منتجات'),
                  )
                : ListView.builder(
                    itemCount: adminProvider.allProducts!.length,
                    itemBuilder: (context, index) {
                      return ProductWidget(adminProvider.allProducts![index]);
                    }));
      },
    );
  }
}
