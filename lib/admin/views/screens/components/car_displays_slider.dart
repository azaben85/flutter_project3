import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/widgets/car_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllCarsSlider extends StatelessWidget {
  const AllCarsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(builder: (context, provider, w) {
      if (provider.allCars == null) {
        return const SizedBox(
          width: double.infinity,
          height: 201,
          child: Center(
            child: Text('No Cars Found'),
          ),
        );
      } else {
        return SizedBox(
          height: 400,
          width: 390.w,
          child: ListView.builder(
              itemCount: provider.allCars!.length,
              itemBuilder: (context, index) {
                return CarWidget(provider.allCars![index]);
              }),
        );
      }
    });
  }
}
