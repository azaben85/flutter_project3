import 'package:firebase_app/admin/models/cars.dart';
import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/components/custom_CarouselSlider.dart';
import 'package:firebase_app/auth/components/custom_label_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayCarDetails extends StatelessWidget {
  Car car;

  DisplayCarDetails(this.car);

  @override
  Widget build(BuildContext context) {
    int colorIndex = 2;
    List<ImageSourceWidget> selectImages = [];
    if (car.imageURLs != null && car.imageURLs!.isNotEmpty) {
      selectImages = car.imageURLs!.map((e) {
        return ImageSourceWidget(
          e,
          source: 'Network',
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${car.addressCity} - ${car.type} ${car.model} ${car.productionYear}'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CarProvider>(context, listen: false).deleteCar(car);
                AppRouter.appRouter.pop();
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Provider.of<CarProvider>(context, listen: false)
                    .loadForUpdate(car);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
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
              LabelValue('Engine Power: ', '${car.enginePower}', ++colorIndex),
              LabelValue(
                  'Passenger Count: ', '${car.passengerCount}', ++colorIndex),
              LabelValue('price: ', '${car.price}', ++colorIndex),
              LabelValue('Payment Method: ', car.paymentType, ++colorIndex),
            ],
          ),
        ),
      ]),
    );
  }
}
