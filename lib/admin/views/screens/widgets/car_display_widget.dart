import 'package:firebase_app/admin/models/cars.dart';
import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/car_add_new.dart';
import 'package:firebase_app/admin/views/screens/display_car_details.dart';
import 'package:firebase_app/admin/views/screens/widgets/display_images_widget.dart';
import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_label_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    User? user = AuthHelper.authHelper.getLoggedUser();
    String userId = user?.uid ?? '';
    bool myList =
        Provider.of<CarProvider>(context, listen: false).checkIfMyList(car);
    return Container(
      width: 390.w,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        //border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        children: [
          Container(
              height: 60,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 235, 235),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    //topRight: Radius.circular(15)
                  ),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (userId == car.userId)
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Provider.of<CarProvider>(context, listen: false)
                                .loadForUpdate(car);

                            AppRouter.appRouter.push(AddNewCar());
                          },
                          icon: const Icon(Icons.edit)),
                    )
                  else
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 239, 235, 235),
                      radius: 20,
                    ),
                  if (userId == car.userId)
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Provider.of<CarProvider>(context, listen: false)
                                .deleteCar(car);
                          },
                          icon: const Icon(Icons.delete)),
                    )
                  else
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 239, 235, 235),
                      radius: 20,
                    ),
                  if (user != null)
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Provider.of<CarProvider>(context, listen: false)
                                .addRemoveToMyList(car, myList);
                            //AppRouter.appRouter.push(const DisplayCarDetails());
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: myList ? Colors.red : Colors.green,
                          )),
                    ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          Provider.of<CarProvider>(context, listen: false)
                              .selectCarForDetails(car);
                          AppRouter.appRouter.push(const DisplayCarDetails());
                        },
                        icon: const Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ],
              )),
          if (selectImages.isNotEmpty)
            Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 235, 235),
                    border: Border.all(color: Colors.black, width: .5)),
                child: DisplayImages(car.imageURLs!)),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 235, 235),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(15)),
                border: Border.all(color: Colors.black, width: 1)),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LabelValue('Car Type: ', '${car.type} - ${car.model}', 2),
                    LabelValue('Price: ', '${car.price}', 3),
                    LabelValue('City: ', car.addressCity, 4),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
