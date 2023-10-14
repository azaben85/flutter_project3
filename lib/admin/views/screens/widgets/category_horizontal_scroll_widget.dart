import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/widgets/category_small_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryHorizontalScrollWidget extends StatelessWidget {
  const CategoryHorizontalScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, w) {
        return provider.allCategories == null
            ? const Center(
                child: Text('لا يوجد اصناف'),
              )
            : SizedBox(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.allCategories!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (provider.allCategories?[index].id ==
                              provider.catID) {
                            Provider.of<AdminProvider>(context, listen: false)
                                .loadProducts(null);
                          } else {
                            Provider.of<AdminProvider>(context, listen: false)
                                .loadProducts(
                                    provider.allCategories?[index].id);
                          }
                        },
                        child: CategorySmallIconWidget(
                            provider.allCategories![index],
                            provider.catID ==
                                provider.allCategories![index].id),
                      );
                    }),
              );
      },
    );
  }
}
