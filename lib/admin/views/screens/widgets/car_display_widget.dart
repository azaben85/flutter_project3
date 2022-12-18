import 'package:firebase_app/admin/models/cars.dart';
import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/display_car_details.dart';
import 'package:firebase_app/admin/views/screens/widgets/car_images_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/components/custom_label_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarWidget extends StatelessWidget {
  Car car;
  CarWidget(this.car);
  @override
  Widget build(BuildContext context) {
    List<ImageSourceWidget> selectImages = [];
    if (car.imageURLs != null && car.imageURLs!.isNotEmpty) {
      selectImages = car.imageURLs!.map((e) {
        return ImageSourceWidget(
          e,
          source: 'Network',
        );
      }).toList();
    }
    if (selectImages.length > 3) {
      selectImages.removeRange(0, 3);
    }

    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        children: [
          Stack(
            children: [
              if (selectImages.isNotEmpty && selectImages.length > 0)
                SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: CarImages(selectImages: selectImages),
                ),
              if (selectImages.isEmpty || selectImages.length == 0)
                Container(
                  width: double.infinity,
                  height: 170,
                  color: Colors.grey,
                ),
              Positioned(
                  right: 15,
                  top: 10,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Provider.of<CarProvider>(context, listen: false)
                                  .deleteCar(car);
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Provider.of<CarProvider>(context, listen: false)
                                  .loadForUpdate(car);
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ],
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LabelValue(
                            'Car Type: ', '${car.type} - ${car.model}', 2),
                        LabelValue('Price: ', '${car.price}', 3),
                        LabelValue('City: ', car.addressCity, 4),
                      ]),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    AppRouter.appRouter.push(DisplayCarDetails(car));
                  },
                  child: const Center(
                    child: Text(
                      'Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
