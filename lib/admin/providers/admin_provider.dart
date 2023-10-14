import 'dart:io';

import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/models/commerce_settings.dart';
import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/admin/views/screens/add_product.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/data_repository/firestore_helper.dart';
import 'package:firebase_app/data_repository/image_picker_helper.dart';
import 'package:firebase_app/data_repository/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import 'package:firebase_app/admin/models/slider.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllProducts();
    getAllCategories();
    getAllSliders();
    getCommerceSettings();
  }
  GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
  GlobalKey<FormState> commerceSettingsKey = GlobalKey<FormState>();
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  File? imageFile;
  String? imageURL;
  String? catID;

  CommerceSettingsModel? settings;
  int? sliderIndex = 0;

  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController shippingController = TextEditingController();

  getCommerceSettings() async {
    settings = await FirestorHelper.firestorHelper.getCommerceSettings();
    whatsappNumberController.text = settings?.whatsappNumber ?? "";
    shippingController.text = '${settings?.shippingValue ?? ""}';
    notifyListeners();
  }

  updateCommerceSettings() async {
    if (commerceSettingsKey.currentState!.validate()) {
      if (settings == null) {
        settings = CommerceSettingsModel(
            whatsappNumber: whatsappNumberController.text,
            shippingValue: double.parse('${shippingController.text}'));
        String? documentId =
            await FirestorHelper.firestorHelper.addCommerceSetting(settings!);

        settings!.id = documentId;
      } else {
        settings!.whatsappNumber = whatsappNumberController.text;
        settings!.shippingValue = double.parse('${shippingController.text}');
        await FirestorHelper.firestorHelper.updateCommerceSetting(settings!);
      }
      AppRouter.appRouter.pop();
    }
  }

  setSliderIndex(int sliderIndex) {
    this.sliderIndex = sliderIndex;
    notifyListeners();
  }

  List<Category>? allCategories;

  loadProducts(String? catID) async {
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
    productID = null;
    allProducts = null;
    //notifyListeners();
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  String? validateWhatsappNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    } else if (!isFloat(text)) {
      return 'Must be numeric';
    } else if (text.length != 14) {
      return 'يجب ان يكون 14 رقم شامل المقدمة';
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
      AppRouter.appRouter.showCustomDialog('اختر صورة', 'رجاءا، اختر صورة');
    }
  }

  deleteCategory(Category category) async {
    AppRouter.appRouter.showProgressBar();
    String imageURLForDelete = category.imageUrl;
    String? catIdForDelete = category.id;

    bool status =
        await FirestorHelper.firestorHelper.deleteCategory(category.id!);
    if (status) {
      allCategories!.remove(category);
      StorageHelper.storageHelper.deleteImages(imageURLForDelete);
      List<Product>? productsToBeDeleted =
          await getAllProductsForDelete(catIdForDelete ?? "na");
      if (productsToBeDeleted != null) {
        for (Product productToBeDeleted in productsToBeDeleted) {
          await deleteProduct(productToBeDeleted);
        }
      }
    }
    clearCatFields();
    notifyListeners();
    //getAllCategories();
    AppRouter.appRouter.pop();
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> addProductKey = GlobalKey<FormState>();

  List<Product>? allProducts;
  String? productID;
  clearProductFields() {
    productNameController.text = '';
    productDescController.text = '';
    productPriceController.text = '';
    imageFile = null;
    imageURL = null;
    productID = null;
    //notifyListeners();
  }

  loadProductForUpdate(Product product) {
    productNameController.text = product.nameEn;
    productDescController.text = product.descEn;
    productPriceController.text = '${product.price}';
    imageURL = product.imageUrl;
    productID = product.id;

    AppRouter.appRouter.push(AddNewProduct());
  }

  getAllProducts() async {
    allProducts = await FirestorHelper.firestorHelper.getAllProducts(catID);
    notifyListeners();
  }

  Future<List<Product>?> getAllProductsForDelete(String catIdForDelete) async {
    List<Product>? allProductsForDelete =
        await FirestorHelper.firestorHelper.getAllProducts(catIdForDelete);
    return allProductsForDelete;
  }

  deleteProduct(Product product) async {
    AppRouter.appRouter.showProgressBar();

    String imageURLForDelete = product.imageUrl;
    bool status =
        await FirestorHelper.firestorHelper.deleteProduct(product.id!);
    if (status) {
      allProducts!.remove(product);
      notifyListeners();
      StorageHelper.storageHelper.deleteImages(imageURLForDelete);
    }
    //getAllCategories();
    AppRouter.appRouter.pop();
  }

  addProduct() async {
    if (imageFile != null || productID != null) {
      if (addProductKey.currentState!.validate()) {
        AppRouter.appRouter.showProgressBar();
        String url = '';
        if (imageFile != null) {
          url = await StorageHelper.storageHelper
              .uploadNewImage('cat_images', imageFile!);
        } else {
          url = imageURL!;
        }
        Product product = Product(
            id: productID,
            nameEn: productNameController.text,
            imageUrl: url,
            nameAr: productNameController.text,
            descAr: productDescController.text,
            descEn: productDescController.text,
            price: double.parse('${productPriceController.text}'),
            catId: catID);

        if (productID == null) {
          await FirestorHelper.firestorHelper.addNewProduct(product);
        } else {
          bool? updated =
              await FirestorHelper.firestorHelper.updateProduct(product);
        }

        clearProductFields();
        loadProducts(catID!);
        AppRouter.appRouter.pop();
        AppRouter.appRouter.pop();
      }
    } else {
      AppRouter.appRouter.showCustomDialog('اختر صورة', 'رجاءا، اختر صورة');
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
