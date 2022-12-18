import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/add_product.dart';
import 'package:firebase_app/admin/views/screens/widgets/product_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayProducts extends StatelessWidget {
  const DisplayProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, w) {
        return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      AppRouter.appRouter.push(AddNewProduct());
                    },
                    icon: const Icon(Icons.add))
              ],
              title: const Text('Display Products'),
            ),
            body: provider.allProducts == null
                ? const Center(
                    child: Text('No Categories Found'),
                  )
                : ListView.builder(
                    itemCount: provider.allProducts!.length,
                    itemBuilder: (context, index) {
                      return ProductWidget(provider.allProducts![index]);
                    }));
      },
    );
  }
}
