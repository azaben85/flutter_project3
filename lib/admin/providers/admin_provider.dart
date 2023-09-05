import 'dart:io';

import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/data_repository/firestore_helper.dart';
import 'package:firebase_app/data_repository/image_picker_helper.dart';
import 'package:firebase_app/data_repository/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import 'package:firebase_app/admin/models/slider.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCategories();
    getAllSliders();
  }
  GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  File? imageFile;
  String? imageURL;
  String? catID;

  int? sliderIndex = 0;

  setSliderIndex(int sliderIndex) {
    this.sliderIndex = sliderIndex;
    notifyListeners();
  }

  List<Category>? allCategories;

  loadProducts(String catID) async {
    this.catID = catID;
    await getAllProducts();
    notifyListeners();
  }

  getAllCategories() async {
    allCategories = await FirestorHelper.firestorHelper.getAllCategories();
    notifyListeners();
  }

  loadForCategoryUpdate(Category category) {
    nameArController.text = category.nameAr;
    nameEnController.text = category.nameEn;
    imageURL = category.imageUrl;
    catID = category.id;
    AppRouter.appRouter.push(AddNewCategory());
  }

  clearCatFields() {
    nameArController.text = '';
    nameEnController.text = '';
    sliderURLController.text = '';
    sliderTitleController.text = '';
    imageFile = null;
    imageURL = null;
    catID = null;

    //notifyListeners();
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  String? validateNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    } else if (!isFloat(text)) {
      return 'Must be numeric';
    }
    return null;
  }

  pickImageForCategory() async {
    imageFile =
        await ImagePickerHelper.imagePickerHelper.pickImageFromGallery();
    if (imageFile != null) {
      imageURL = null;
    }
    notifyListeners();
  }

  addCategory() async {
    if (imageFile != null || catID != null) {
      if (categoryKey.currentState!.validate()) {
        AppRouter.appRouter.showProgressBar();
        String url;
        if (imageFile != null) {
          url = await StorageHelper.storageHelper
              .uploadNewImage('cat_images', imageFile!);
        } else {
          url = imageURL!;
        }
        Category category = Category(
            id: catID,
            nameEn: nameEnController.text,
            imageUrl: url,
            nameAr: '');
        if (catID == null) {
          await FirestorHelper.firestorHelper.addNewCategory(category);
        } else {
          await FirestorHelper.firestorHelper.updateCategory(category);
        }
        clearCatFields();
        getAllCategories();

        AppRouter.appRouter.pop();
        AppRouter.appRouter.pop();
      }
    } else {
      AppRouter.appRouter
          .showCustomDialog('Image Required', 'Please select Image First');
    }
  }

  updateCategory() async {
    // if (imageFile != null) {
    //   if (categoryKey.currentState!.validate()) {
    //     String imageUrl = await StorageHelper.storageHelper
    //         .uploadNewImage('cat_images', imageFile!);
    //     Category category = Category(
    //         nameEn: nameEnController.text,
    //         imageUrl: imageUrl,
    //         nameAr: nameArController.text);
    //     await FirestorHelper.firestorHelper.updateCategory(category);
    //     clearFields();
    //   }
    // }
  }

  deleteCategory(Category category) async {
    AppRouter.appRouter.showProgressBar();

    bool status =
        await FirestorHelper.firestorHelper.deleteCategory(category.id!);
    if (status) {
      allCategories!.remove(category);
      notifyListeners();
    }
    //getAllCategories();
    AppRouter.appRouter.pop();
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> addProductKey = GlobalKey<FormState>();

  List<Product>? allProducts;

  clearProductFields() {
    productNameController.text = '';
    productDescController.text = '';
    productPriceController.text = '';
    imageFile = null;
    imageURL = null;
    //notifyListeners();
  }

  getAllProducts() async {
    allProducts = await FirestorHelper.firestorHelper.getAllProducts(catID!);
    notifyListeners();
  }

  addProduct() async {
    if (imageFile != null) {
      if (addProductKey.currentState!.validate()) {
        AppRouter.appRouter.showProgressBar();
        String url = '';
        if (imageFile != null) {
          url = await StorageHelper.storageHelper
              .uploadNewImage('cat_images', imageFile!);
        } else {}
        Product product = Product(
            nameEn: productNameController.text,
            imageUrl: url,
            nameAr: productNameController.text,
            descAr: productDescController.text,
            descEn: productDescController.text,
            price: double.parse('${productPriceController.text}'),
            catId: catID);

        await FirestorHelper.firestorHelper.addNewProduct(product);

        clearProductFields();
        loadProducts(catID!);
        AppRouter.appRouter.pop();
        AppRouter.appRouter.pop();
      }
    } else {
      AppRouter.appRouter
          .showCustomDialog('Image Required', 'Please select Image First');
    }
  }

  List<SliderModel>? allSliders;
  GlobalKey<FormState> sliderKey = GlobalKey<FormState>();
  TextEditingController sliderTitleController = TextEditingController();
  TextEditingController sliderURLController = TextEditingController();

  clearSlidersFields() {
    sliderURLController.text = '';
    sliderTitleController.text = '';
    imageFile = null;
    imageURL = null;
  }

  getAllSliders() async {
    allSliders = await FirestorHelper.firestorHelper.getAllSliders();
    notifyListeners();
  }

  addSlider() async {
    if (imageFile != null) {
      if (sliderKey.currentState!.validate()) {
        AppRouter.appRouter.showProgressBar();
        String url;

        url = await StorageHelper.storageHelper
            .uploadNewImage('slider_images', imageFile!);

        SliderModel slider = SliderModel(
            id: catID,
            title: sliderTitleController.text,
            url: sliderURLController.text,
            imageURL: url);

        await FirestorHelper.firestorHelper.addNewSlider(slider);

        clearCatFields();
        getAllSliders();

        AppRouter.appRouter.pop();
        AppRouter.appRouter.pop();
      }
    } else {
      AppRouter.appRouter
          .showCustomDialog('Image Required', 'Please select Image First');
    }
  }
}
