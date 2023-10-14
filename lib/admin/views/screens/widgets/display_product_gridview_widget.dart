import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayProductGridviewWidget extends StatelessWidget {
  bool edit;
  DisplayProductGridviewWidget({this.edit = false});
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, w) {
        return adminProvider.allProducts == null
            ? const Center(
                child: Text('لا يوجد منتجات'),
              )
            : GridView.builder(
                itemCount: adminProvider.allProducts!.length,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    adminProvider.allProducts![index],
                    edit: edit,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              );
      },
    );
  }
}
