import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScaffold(
      title: "المنتج",
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Container(
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
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: provider.imageFile == null
                        ? const Center(
                            child: Icon(Icons.camera),
                          )
                        : Image.file(
                            provider.imageFile!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
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
                    child: const Text('اضف منتج جديد'),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
