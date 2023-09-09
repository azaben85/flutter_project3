import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/providers/order_provider.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  ProductWidget(this.product);
  @override
  Widget build(BuildContext context) {
    User? user = AuthHelper.authHelper.getLoggedUser();
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.network(
                    product.imageUrl,
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
                                // Provider.of<AdminProvider>(context,
                                //         listen: false)
                                //     .deleteCategory(product);
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
                                // Provider.of<AdminProvider>(context,
                                //         listen: false)
                                //     .loadForCategoryUpdate(product);
                              },
                              icon: const Icon(Icons.edit)),
                        ),
                      ],
                    ))
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'المنتج' + ': ' + product.nameEn,
                        ),
                        Text(
                          'السعر: ' + product.price.toString(),
                        ),
                      ]),
                ),
                InkWell(
                  child: Text("اضف الى السلة"),
                  onTap: () {
                    Provider.of<OrderProvider>(context, listen: false)
                        .addItem(product, "cat");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
