import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_checkboxdisplay.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_app/admin/models/cars.dart';
import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/car_add_new.dart';
import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/components/custom_CarouselSlider.dart';
import 'package:firebase_app/auth/components/custom_label_value.dart';

class DisplayCarDetails extends StatelessWidget {
  const DisplayCarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    int colorIndex = 2;

    User? user = AuthHelper.authHelper.getLoggedUser();
    String userId = user?.uid ?? '';

    return Consumer<CarProvider>(builder: (context, provider, child) {
      if (provider.selectedCar == null) return Container();
      Car car = provider.selectedCar!;
      List<ImageSourceWidget> selectImages = [];

      if (car.imageURLs != null && car.imageURLs!.isNotEmpty) {
        selectImages = car.imageURLs!.map((e) {
          return ImageSourceWidget(
            e,
            source: 'Network',
          );
        }).toList();
      }
      bool myList = provider.checkIfMyList(car);

      return CustomScaffold(
        title: '${car.addressCity}',
        bottomTitle: '${car.type} ${car.model} - ${car.productionYear}',
        actions: [
          if (user != null)
            IconButton(
                onPressed: () {
                  provider.addRemoveToMyList(car, myList);
                  //AppRouter.appRouter.push(const DisplayCarDetails());
                },
                icon: Icon(
                  Icons.favorite,
                  color: myList ? Colors.red : Colors.green,
                )),
          if (userId == car.userId)
            IconButton(
                onPressed: () {
                  provider.deleteCar(car);
                  AppRouter.appRouter.pop();
                },
                icon: const Icon(Icons.delete)),
          if (userId == car.userId)
            IconButton(
                onPressed: () {
                  provider.loadForUpdate(car);

                  AppRouter.appRouter.push(AddNewCar());
                },
                icon: const Icon(Icons.edit))
        ],
        body: ListView(children: [
          const SizedBox(
            height: 10,
          ),
          if (selectImages.isNotEmpty) CustomeCarouselSlider(selectImages),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                LabelValue('Fuel Type: ', car.fuelType, ++colorIndex),
                LabelValue('Gear Type: ', car.gearType, ++colorIndex),
                LabelValue('Window Control: ', car.windowControl, ++colorIndex),
                LabelValue('Engine Power: ', car.enginePower, ++colorIndex),
                LabelValue(
                    'Passenger Count: ', '${car.passengerCount}', ++colorIndex),
                LabelValue('price: ', '${car.price}', ++colorIndex),
                LabelValue('Payment Method: ', car.paymentType, ++colorIndex),
                LabelValue('Payment Method: ', car.paymentType, ++colorIndex),
                const SizedBox(
                  height: 5,
                ),
                LabelValue('Addendums: ', '', 0),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                            CheckboxDisplay(car.airCondition, 'Air Condition')),
                    Expanded(
                        child: CheckboxDisplay(
                            car.centralControl, 'Central Control')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: CheckboxDisplay(
                            car.magnesiumWheels, 'Magnesium Wheels')),
                    Expanded(
                        child: CheckboxDisplay(car.leatherSeatUpholstery,
                            'Leather Seat Upholstery')),
                  ],
                )
              ],
            ),
          ),
        ]),
      );
    });
  }
}
