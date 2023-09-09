import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/admin/views/screens/widgets/cart_icon_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/category_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    User? user = AuthHelper.authHelper.getLoggedUser();
    return Consumer<AdminProvider>(
      builder: (context, provider, w) {
        return CustomScaffold(
            actions: user != null
                ? [
                    CartIcon(),
                    IconButton(
                        onPressed: () {
                          provider.clearCatFields();
                          AppRouter.appRouter.push(AddNewCategory());
                        },
                        icon: const Icon(Icons.add))
                  ]
                : [CartIcon()],
            title: 'الاصناف',
            body: provider.allCategories == null
                ? const Center(
                    child: Text('لا يوجد اصناف'),
                  )
                : ListView.builder(
                    itemCount: provider.allCategories!.length,
                    itemBuilder: (context, index) {
                      return CategoryWidget(provider.allCategories![index]);
                    }));
      },
    );
  }
}
