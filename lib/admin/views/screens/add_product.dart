import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AdminProvider>(builder: (context, provider, w) {
      return CustomScaffold(
        title: provider.productID == null ? 'أضف منتج جديد' : 'تعديل المنتج',
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.addProductKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
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
                    )),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    inputController: provider.productNameController,
                    label: 'اسم المنتج',
                    validation: provider.validateText),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  inputController: provider.productDescController,
                  label: 'وصف المنتج',
                  validation: provider.validateText,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  inputType: TextInputType.number,
                  inputController: provider.productPriceController,
                  label: 'سعر المنتج',
                  validation: provider.validateNumber,
                ),
                //const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.addProduct();
                    },
                    child: Text(provider.productID == null
                        ? 'أضف منتج جديد'
                        : 'عدل المنتج'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
