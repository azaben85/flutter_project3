import 'package:firebase_app/auth/components/custom_customcheckboxlisttile.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/widgets/car_images_widget.dart';
import 'package:firebase_app/auth/components/custom_dropdownbutton.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';

class AddNewCar extends StatelessWidget {
  List<String> carTypes = ['Opel', ' BMW', 'Seat', 'Mercede', 'KIA', 'DS'];
  List<String> fuelType = ['Gasoline', 'Diesel'];
  List<String> windowControl = [
    'Manual Window Control',
    'Electric Window Control'
  ];
  List<String> gearType = ['Manual Gear', 'Automatic Gear'];
  List<String> paymentWay = ['Cash', 'Accept Checks'];
  List<String> cities = [
    'Nablus',
    'Tulkarem',
    'Jenin',
    'Rammallah',
    'Hebron',
    'Jerusalem',
    'Jericho',
    'Ateel'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(builder: (context, provider, child) {
      return CustomScaffold(
          title: '${provider.selectedCar == null ? 'Add' : 'Edit'} Car',
          body: Form(
            key: provider.carKey,
            child: ListView(
              children: [
                InkWell(
                    onTap: () {
                      provider.pickImageForCategory();
                    },
                    child: Icon(Icons.camera)),
                Container(
                  height: 150,
                  //width: 150,
                  color: Colors.grey,
                  child: provider.selectImages == null
                      ? const Center(
                          child: Icon(Icons.image),
                        )
                      : CarImages(selectImages: provider.selectImages!),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomDropDownButton(
                    hint: 'City',
                    values: cities,
                    onChanged: provider.setAddressCity,
                    value: provider.addressCity),
                CustomDropDownButton(
                    hint: 'Car Type',
                    values: carTypes,
                    onChanged: provider.setType,
                    value: provider.type),
                CustomTextField(
                    inputController: provider.modelTypeController,
                    validation: provider.validateText,
                    label: 'Model Type'),
                CustomTextField(
                    inputType: TextInputType.number,
                    inputController: provider.productionYearController,
                    validation: provider.validateInteger,
                    label: 'Year of Production (i.e. 2022)'),
                CustomDropDownButton(
                    hint: 'Gear Type',
                    values: gearType,
                    onChanged: provider.setGearType,
                    value: provider.gearType),
                CustomTextField(
                    inputType: TextInputType.number,
                    inputController: provider.enginePowerController,
                    validation: provider.validateText,
                    label: 'Engine Power'),
                CustomTextField(
                    inputType: TextInputType.number,
                    inputController: provider.passengerCountController,
                    validation: provider.validateInteger,
                    label: 'Passenger Count'),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          inputType: TextInputType.number,
                          inputController: provider.priceController,
                          validation: provider.validateNumber,
                          label: 'Price'),
                    ),
                    Expanded(
                      child: CustomDropDownButton(
                          hint: 'Payment Method',
                          values: paymentWay,
                          onChanged: provider.setPaymentType,
                          value: provider.paymentType),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomDropDownButton(
                        hint: 'Fuel',
                        values: fuelType,
                        onChanged: provider.setFuelType,
                        value: provider.fuelType),
                    Expanded(
                      child: CustomDropDownButton(
                          hint: 'Window Control',
                          values: windowControl,
                          onChanged: provider.setWindowControl,
                          value: provider.windowControl),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomCheckboxListTile(
                        label: 'AC',
                        value: provider.airCondition,
                        onChnaged: provider.setAirCondition),
                    CustomCheckboxListTile(
                        label: 'Central Control',
                        value: provider.centralControl,
                        onChnaged: provider.setCentralControl),
                  ],
                ),
                Row(
                  children: [
                    CustomCheckboxListTile(
                        label: 'Magnesium Wheels',
                        value: provider.magnesiumWheels,
                        onChnaged: provider.setMagnesiumWheels),
                    CustomCheckboxListTile(
                        label: 'Leather Seat',
                        value: provider.leatherSeatUpholstery,
                        onChnaged: provider.setLeatherSeatUpholstery),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        provider.addUpdateCar();
                      },
                      child: Text(
                          '${provider.selectedCar == null ? 'Add New' : 'Edit'} Car')),
                )
              ],
            ),
          ));
    });
  }
}
