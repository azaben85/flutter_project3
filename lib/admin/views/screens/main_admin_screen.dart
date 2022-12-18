import 'package:firebase_app/admin/views/screens/add_new_slider.dart';
import 'package:firebase_app/admin/views/screens/car_display_car.dart';
import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';

class MainAdminScreen extends StatelessWidget {
  const MainAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.grey),
              child: InkWell(
                  onTap: () {
                    AppRouter.appRouter.push(DisplayCars());
                  },
                  child: Center(child: Text('Cars'))),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.grey),
              child: InkWell(
                  onTap: () {
                    AppRouter.appRouter.push(AllCategoriesScreen());
                  },
                  child: Center(child: Text('categories'))),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.grey),
              child: InkWell(
                  onTap: () {
                    AppRouter.appRouter.push(AddNewSlider());
                  },
                  child: Center(child: Text('Sliders'))),
            ),
          ),
        ]),
      ),
    );
  }
}
