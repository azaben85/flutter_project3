import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/admin/models/cars.dart';
import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/models/commerce_settings.dart';
import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/models/slider.dart';
import 'package:firebase_app/admin/models/mylist.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/helpers/app_helper.dart';
import 'package:firebase_app/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorHelper {
  FirestorHelper._();
  static FirestorHelper firestorHelper = FirestorHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Register
  addNewUser(AppUser appUser) async {
    log(appUser.toMap().toString());
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  //Login
  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('users').doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    AppUser appUser = AppUser.fromMap(data!);
    appUser.id = id;
    return appUser;
  }

  updateUser(AppUser appUser) async {
    try {
      firestore.collection('users').doc(appUser.id).set(appUser.toMap());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<String?> addCommerceSetting(CommerceSettingsModel settings) async {
    try {
      DocumentReference<Map<String, dynamic>> document =
          await firestore.collection('commerceSettings').add(settings.toMap());
      return document.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<bool?> updateCommerceSetting(CommerceSettingsModel settings) async {
    try {
      await firestore
          .collection('commerceSettings')
          .doc(settings.id)
          .update(settings.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CommerceSettingsModel?> getCommerceSettings() async {
    QuerySnapshot<Map<String, dynamic>> catsSnapshot =
        await firestore.collection('commerceSettings').get();
    List<CommerceSettingsModel> documents = catsSnapshot.docs.map(
      (e) {
        CommerceSettingsModel document =
            CommerceSettingsModel.fromMap(e.data());
        document.id = e.id;
        return document;
      },
    ).toList();

    if (documents.isEmpty) {
      return null;
    }
    return documents[0];
  }

  /// admin methods
  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> catDocument =
          await firestore.collection('categories').add(category.toMap());
      return catDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<bool> deleteCategory(String catId) async {
    try {
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Category>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> catsSnapshot =
        await firestore.collection('categories').get();
    List<Category> cats = catsSnapshot.docs.map(
      (e) {
        Category cat = Category.fromMap(e.data());
        cat.id = e.id;
        return cat;
      },
    ).toList();
    return cats;
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  addNewProduct(Product product) async {
    try {
      String documentId = getCurrentDateTimeFormatted();
      await firestore
          .collection('products')
          .doc(documentId)
          .set(product.toMap());
      return documentId;
    } on Exception catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<List<Product>?> getAllProducts(String? catId) async {
    if (catId == null) {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot = await firestore
          // .collection('categories')
          // .doc(catId)
          .collection('products')
          // .orderBy(FieldPath.documentId, descending: true)
          .get();
      List<Product> products = catsSnapshot.docs.map(
        (e) {
          Product prod = Product.fromMap(e.data());
          prod.id = e.id;
          return prod;
        },
      ).toList();
      return products;
    }
    QuerySnapshot<Map<String, dynamic>> catsSnapshot = await firestore
        // .collection('categories')
        // .doc(catId)
        .collection('products')
        .where("catId", isEqualTo: catId)
        .orderBy(FieldPath.documentId, descending: true)
        .get();
    List<Product> products = catsSnapshot.docs.map(
      (e) {
        Product prod = Product.fromMap(e.data());
        prod.id = e.id;
        return prod;
      },
    ).toList();
    return products;
  }

  Future<bool> deleteProduct(String prodId) async {
    try {
      await firestore.collection('products').doc(prodId).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateProduct(Product product) async {
    try {
      await firestore
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String?> addNewSlider(SliderModel slider) async {
    try {
      DocumentReference<Map<String, dynamic>> document =
          await firestore.collection('sliders').add(slider.toMap());
      return document.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<List<SliderModel>> getAllSliders() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('sliders').get();
    List<SliderModel> allSliders = snapshot.docs.map(
      (e) {
        SliderModel slider = SliderModel.fromMap(e.data());
        slider.id = e.id;
        return slider;
      },
    ).toList();
    return allSliders;
  }

  Future<String?> addNewCar(Car car) async {
    try {
      DocumentReference<Map<String, dynamic>> document =
          await firestore.collection('car').add(car.toMap());
      return document.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<List<Car>> getAllCars() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('car').get();
    List<Car> allCars = snapshot.docs.map(
      (e) {
        Car car = Car.fromMap(e.data());
        car.id = e.id;
        return car;
      },
    ).toList();
    return allCars;
  }

  Future<bool?> updateCar(Car car) async {
    try {
      await firestore.collection('car').doc(car.id).update(car.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCar(String carId) async {
    try {
      await firestore.collection('car').doc(carId).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String?> addNewMyList(MyList myList) async {
    try {
      DocumentReference<Map<String, dynamic>> document =
          await firestore.collection('mylist').add(myList.toMap());
      return document.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<bool> deleteFromMyList(String id) async {
    try {
      await firestore.collection('mylist').doc(id).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<MyList>> getMyList() async {
    User? user = AuthHelper.authHelper.getLoggedUser();
    if (user == null) return [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('mylist')
        .where('userId', isEqualTo: user.uid)
        .where('type', isEqualTo: 'car')
        .get();
    List<MyList> allLists = snapshot.docs.map(
      (e) {
        MyList myList = MyList.fromMap(e.data());
        myList.id = e.id;
        return myList;
      },
    ).toList();
    return allLists;
  }
}
