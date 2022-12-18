import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/admin/views/screens/widgets/category_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AdminProvider>(
      builder: (context, provider, w) {
        return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      provider.clearCatFields();
                      AppRouter.appRouter.push(AddNewCategory());
                    },
                    icon: const Icon(Icons.add))
              ],
              title: const Text('All Categories'),
            ),
            body: provider.allCategories == null
                ? const Center(
                    child: Text('No Categories Found'),
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
