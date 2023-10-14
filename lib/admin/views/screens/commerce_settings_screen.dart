import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommerceSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, child) {
      return CustomScaffold(
          title: "الاعدادات",
          body: Form(
            key: provider.commerceSettingsKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text("رقم واتس اب المرسل اليه:"),
                CustomTextField(
                    inputController: provider.whatsappNumberController,
                    validation: provider.validateWhatsappNumber,
                    inputType: TextInputType.phone,
                    label: 'رقم واتس اب المرسل اليه'),
                const SizedBox(
                  height: 30,
                ),
                const Text("رسوم التوصيل:"),
                CustomTextField(
                    inputController: provider.shippingController,
                    validation: provider.validateNumber,
                    inputType: TextInputType.number,
                    label: 'رسوم التوصيل'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        provider.updateCommerceSettings();
                      },
                      child: const Text("تحديث")),
                )
              ],
            ),
          ));
    });
  }
}
