import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/display_product.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  User? user = AuthHelper.authHelper.getLoggedUser();

  Category category;
  CategoryWidget(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Provider.of<AdminProvider>(context, listen: false)
                  .loadProducts(category.id!);
              AppRouter.appRouter.push(DisplayProducts());
            },
            child: Stack(
              children: [
                SizedBox(
                    width: 350,
                    height: 170,
                    child: Image.network(
                      category.imageUrl,
                      fit: BoxFit.cover,
                    )),
                if (user != null)
                  Positioned(
                      right: 15,
                      top: 10,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .deleteCategory(category);
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .loadForCategoryUpdate(category);
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        ],
                      ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'الصنف' + ': ' + category.nameEn,
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
