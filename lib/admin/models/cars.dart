import 'dart:convert';

class Car {
  String? id;
  String userId;
  String type;
  String model;
  String addressCity;
  String enginePower;
  String gearType;
  int productionYear;
  double price;
  String paymentType;
  String fuelType;
  int passengerCount;
  bool airCondition;
  String windowControl;
  bool leatherSeatUpholstery;
  bool magnesiumWheels;
  bool centralControl;
  List<String>? imageURLs;
  Car({
    this.id,
    required this.userId,
    required this.type,
    required this.model,
    required this.addressCity,
    required this.enginePower,
    required this.gearType,
    required this.productionYear,
    required this.price,
    required this.paymentType,
    required this.fuelType,
    required this.passengerCount,
    required this.airCondition,
    required this.windowControl,
    required this.leatherSeatUpholstery,
    required this.magnesiumWheels,
    required this.centralControl,
    this.imageURLs,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'model': model,
      'addressCity': addressCity,
      'enginePower': enginePower,
      'gearType': gearType,
      'productionYear': productionYear,
      'price': price,
      'paymentType': paymentType,
      'fuelType': fuelType,
      'passengerCount': passengerCount,
      'airCondition': airCondition,
      'windowControl': windowControl,
      'leatherSeatUpholstery': leatherSeatUpholstery,
      'magnesiumWheels': magnesiumWheels,
      'centralControl': centralControl,
      'imageURLs': imageURLs,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      userId: map['userId'] ?? '',
      type: map['type'] ?? '',
      model: map['model'] ?? '',
      addressCity: map['addressCity'] ?? '',
      enginePower: map['enginePower'] ?? '',
      gearType: map['gearType'] ?? '',
      productionYear: map['productionYear']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      paymentType: map['paymentType'] ?? '',
      fuelType: map['fuelType'] ?? '',
      passengerCount: map['passengerCount']?.toInt() ?? 0,
      airCondition: map['airCondition'] ?? false,
      windowControl: map['windowControl'] ?? '',
      leatherSeatUpholstery: map['leatherSeatUpholstery'] ?? false,
      magnesiumWheels: map['magnesiumWheels'] ?? false,
      centralControl: map['centralControl'] ?? false,
      imageURLs: List<String>.from(map['imageURLs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));
}
