import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/car_add_new.dart';
import 'package:firebase_app/admin/views/screens/widgets/car_display_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayCars extends StatelessWidget {
  const DisplayCars({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(builder: (context, provider, w) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Cars'),
            actions: [
              IconButton(
                  onPressed: () {
                    provider.clearFields();
                    AppRouter.appRouter.push(AddNewCar());
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: provider.allCars == null
              ? const Center(
                  child: Text('No Categories Found'),
                )
              : ListView.builder(
                  itemCount: provider.allCars!.length,
                  itemBuilder: (context, index) {
                    return CarWidget(provider.allCars![index]);
                  }));
    });
  }
}
