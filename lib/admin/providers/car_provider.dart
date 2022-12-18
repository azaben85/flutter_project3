import 'dart:developer';

import 'package:firebase_app/admin/models/cars.dart';
import 'package:firebase_app/admin/views/screens/car_add_new.dart';
import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/data_repository/firestore_helper.dart';
import 'package:firebase_app/data_repository/image_picker_helper.dart';
import 'package:firebase_app/data_repository/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class CarProvider extends ChangeNotifier {
  CarProvider() {
    log('Get All Cars');
    getAllCars();
    log('Done XXXXX All Cars');
  }
  GlobalKey<FormState> carKey = GlobalKey<FormState>();
  Car? selectedCar;
  String? type;
  String? gearType;
  String? paymentType;
  String? fuelType;
  String? windowControl;
  bool? airCondition;
  bool? leatherSeatUpholstery;
  bool? magnesiumWheels;
  bool? centralControl;
  String? addressCity;
  TextEditingController modelTypeController = TextEditingController();
  TextEditingController enginePowerController = TextEditingController();
  TextEditingController passengerCountController = TextEditingController();
  TextEditingController productionYearController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<ImageSourceWidget>? selectImages;
  List<String>? carImagesUrls;

  List<Car>? allCars;

  loadForUpdate(Car car) {
    selectedCar = car;
    type = car.type;
    gearType = car.gearType;
    paymentType = car.paymentType;
    fuelType = car.fuelType;
    windowControl = car.windowControl;
    airCondition = car.airCondition;
    leatherSeatUpholstery = car.leatherSeatUpholstery;
    magnesiumWheels = car.magnesiumWheels;
    centralControl = car.centralControl;
    addressCity = car.addressCity;
    modelTypeController.text = car.model;
    enginePowerController.text = car.enginePower;
    passengerCountController.text = car.passengerCount.toString();
    productionYearController.text = car.productionYear.toString();
    priceController.text = car.price.toString();
    if (car.imageURLs != null && car.imageURLs!.isNotEmpty) {
      selectImages = car.imageURLs!.map((e) {
        return ImageSourceWidget(
          e,
          source: 'Network',
        );
      }).toList();
    }
    AppRouter.appRouter.push(AddNewCar());
  }

  clearFields() {
    selectedCar = null;
    type = null;
    gearType = null;
    paymentType = null;
    fuelType = null;
    windowControl = null;
    airCondition = null;
    leatherSeatUpholstery = null;
    magnesiumWheels = null;
    centralControl = null;
    addressCity = null;
    modelTypeController.text = '';
    enginePowerController.text = '';
    passengerCountController.text = '';
    productionYearController.text = '';
    priceController.text = '';
    selectImages = null;
    carImagesUrls = null;
  }

  setMagnesiumWheels(bool magnesiumWheels) {
    this.magnesiumWheels = magnesiumWheels;
    notifyListeners();
  }

  setLeatherSeatUpholstery(bool leatherSeatUpholstery) {
    this.leatherSeatUpholstery = leatherSeatUpholstery;
    notifyListeners();
  }

  setCentralControl(bool centralControl) {
    this.centralControl = centralControl;
    notifyListeners();
  }

  setAirCondition(bool airCondition) {
    this.airCondition = airCondition;
    notifyListeners();
  }

  setPaymentType(String paymentType) {
    this.paymentType = paymentType;
    notifyListeners();
  }

  setGearType(String? gearType) {
    this.gearType = gearType;
    notifyListeners();
  }

  setWindowControl(String windowControl) {
    this.windowControl = windowControl;
    notifyListeners();
  }

  setFuelType(String fuelType) {
    this.fuelType = fuelType;
    notifyListeners();
  }

  setType(String type) {
    this.type = type;
    notifyListeners();
  }

  setAddressCity(String addressCity) {
    this.addressCity = addressCity;
    notifyListeners();
  }

  pickImageForCategory() async {
    List<ImageSourceWidget>? selectImagesTemp =
        await ImagePickerHelper.imagePickerHelper.pickMultiImageFromGallery();
    if (selectImagesTemp != null) {
      if (selectImages == null) {
        selectImages = selectImagesTemp;
      } else {
        selectImages!.addAll(selectImagesTemp.toList());
      }
      notifyListeners();
    }
  }

  getAllCars() async {
    allCars = await FirestorHelper.firestorHelper.getAllCars();
    notifyListeners();
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  String? validateInteger(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    } else if (!isInt(text)) {
      return 'Must be Integer Value';
    }
    return null;
  }

  String? validateNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    } else if (!isFloat(text)) {
      return 'Must be Numeric';
    }
    return null;
  }

  addUpdateCar() async {
    if (carKey.currentState!.validate()) {
      AppRouter.appRouter.showProgressBar();

      List<String>? imageURLs = [];

      if (selectImages != null && selectImages!.isNotEmpty) {
        for (ImageSourceWidget imageSource in selectImages!) {
          if (imageSource.source == 'File') {
            String url = await StorageHelper.storageHelper
                .uploadNewImage('car_images', imageSource.file!);
            imageURLs.add(url);
          } else if (imageSource.source == 'Network') {
            imageURLs.add(imageSource.imageURL);
          }
        }
      }

      Car car = Car(
          id: selectedCar?.id ?? '',
          type: type ?? '',
          model: modelTypeController.text,
          addressCity: addressCity ?? '',
          enginePower: enginePowerController.text,
          gearType: gearType ?? '',
          productionYear: int.parse(productionYearController.text),
          price: double.parse(priceController.text),
          paymentType: paymentType ?? '',
          fuelType: fuelType ?? '',
          passengerCount: int.parse(passengerCountController.text),
          airCondition: airCondition ?? false,
          windowControl: windowControl ?? '',
          leatherSeatUpholstery: leatherSeatUpholstery ?? false,
          magnesiumWheels: magnesiumWheels ?? false,
          centralControl: centralControl ?? false,
          imageURLs: imageURLs);
      if (selectedCar == null) {
        await FirestorHelper.firestorHelper.addNewCar(car);
        getAllCars();
      } else {
        bool updated =
            await FirestorHelper.firestorHelper.updateCar(car) ?? false;
        if (updated) {
          log('Updated Car 123');
          int i = allCars!.indexOf(selectedCar!);
          allCars![i] = car;
          notifyListeners();
        }
      }

      clearFields();
      AppRouter.appRouter.pop();
      AppRouter.appRouter.pop();
    }
  }

  deleteCar(Car car) async {
    AppRouter.appRouter.showProgressBar();
    List<String>? imageUrls = car.imageURLs;
    bool result = await FirestorHelper.firestorHelper.deleteCar(car.id!);

    if (result) {
      if (imageUrls != null) {
        for (String url in imageUrls) {
          bool deleted = await StorageHelper.storageHelper.deleteImages(url);
          if (!deleted) {
            log('fail');
            break;
          }
        }
      }
      allCars!.remove(car);
      notifyListeners();
    }
    AppRouter.appRouter.pop();
  }
}
