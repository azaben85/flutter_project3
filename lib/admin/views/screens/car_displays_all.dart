import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/car_add_new.dart';
import 'package:firebase_app/admin/views/screens/widgets/car_display_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayCars extends StatelessWidget {
  const DisplayCars({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(builder: (context, provider, w) {
      return CustomScaffold(
          title: 'Cars',
          floatingActionButton: AuthHelper.authHelper.getLoggedUser() == null
              ? null
              : FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    provider.clearFields();
                    AppRouter.appRouter.push(AddNewCar());
                  },
                  child: const Icon(Icons.add, color: Colors.black)),
          body: provider.allCars == null
              ? const Center(
                  child: Text('No Cars Found'),
                )
              : ListView.builder(
                  itemCount: provider.allCars!.length,
                  itemBuilder: (context, index) {
                    return CarWidget(provider.allCars![index]);
                  }));
    });
  }
}
