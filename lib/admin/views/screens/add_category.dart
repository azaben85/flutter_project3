import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, child) {
      return CustomScaffold(
          title: provider.catID == null ? 'أضف صنف جديد' : 'تعديل الصنف',
          body: Form(
            key: provider.categoryKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    provider.pickImageForCategory();
                  },
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: provider.imageURL != null
                        ? Image.network(provider.imageURL!)
                        : (provider.imageFile == null)
                            ? const Icon(
                                Icons.camera,
                                size: 60,
                              )
                            : Image.file(provider.imageFile!),
                  ),
                ),
                CustomTextField(
                    inputController: provider.nameEnController,
                    validation: provider.validateText,
                    label: 'الصنف'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        provider.addCategory();
                      },
                      child: Text(
                          provider.catID == null ? 'أضف الصنف' : 'عدل الصنف')),
                )
              ],
            ),
          ));
    });
  }
}
