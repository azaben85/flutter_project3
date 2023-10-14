import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/admin/views/screens/add_product.dart';
import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/admin/views/screens/widgets/cart_icon_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/category_horizontal_scroll_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/category_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/display_product_gridview_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesCustomerScreen extends StatelessWidget {
  const AllCategoriesCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthHelper.authHelper.getLoggedUser();
    return Consumer<AdminProvider>(
      builder: (context, provider, w) {
        return CustomScaffold(
            actions: user != null
                ? [
                    const CartIcon(),
                    InkWell(
                        onTap: () {
                          AppRouter.appRouter.push(AllCategoriesScreen());
                        },
                        child: const Center(child: Text("ادارة المنتجات"))),
                  ]
                : [const CartIcon()],
            title: 'الاصناف',
            body: Container(
              color: const Color.fromARGB(255, 240, 237, 237),
              child: Column(children: [
                const CategoryHorizontalScrollWidget(),
                Expanded(
                    child: DisplayProductGridviewWidget(
                  edit: false,
                ))
              ]),
            ));
      },
    );
  }
}
