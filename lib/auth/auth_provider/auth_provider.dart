import 'dart:developer';
import 'dart:io';

import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/admin/views/screens/display_categories_customer.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/data_repository/firestore_helper.dart';
import 'package:firebase_app/data_repository/storage_helper.dart';
import 'package:firebase_app/models/app_user.dart';
import 'package:firebase_app/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    checkUserInit();
  }
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  AppUser? loggedUser;

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Must have value';
    } else if (!isEmail(email)) {
      return 'Error, must be email';
    }
    return null;
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  String? validatePhome(String number) {
    if (number == null || number.isEmpty) {
      return 'Must have value';
    } else if (!isNumeric(number)) {
      return 'Must be numeric';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Must have value';
    } else if (password.length < 6) {
      return 'Error, the password must have value greater than 6 digites';
    }
    return null;
  }

  clearFields() {
    loginEmail.text = '';
    passwordController.text = '';
    registerEmail.text = '';
    nameController.text = '';
    phoneController.text = '';
  }

  signIn() async {
    if (signInKey.currentState!.validate()) {
      String? result = await AuthHelper.authHelper
          .signIn(loginEmail.text, passwordController.text);

      if (result == null) {
        AppRouter.appRouter.showCustomDialog('Failed', 'LoginFailed');
      } else {
        loggedUser =
            await FirestorHelper.firestorHelper.getUserFromFirestore(result);
        loggedUser!.email = loginEmail.text;
        log(loggedUser!.name!);
        clearFields();
        notifyListeners();
        AppRouter.appRouter.pushReplacementAll(AllCategoriesCustomerScreen());
      }
    }
  }

  signUp() async {
    if (signUpKey.currentState!.validate()) {
      String? result = await AuthHelper.authHelper
          .signUp(registerEmail.text, passwordController.text);
      if (result == null) {
        AppRouter.appRouter.showCustomDialog('Failed', 'Sign Up Failed');
      } else {
        loggedUser = AppUser(
            email: registerEmail.text,
            name: nameController.text,
            phone: phoneController.text,
            id: result);
        FirestorHelper.firestorHelper.addNewUser(loggedUser!);
        clearFields();
        notifyListeners();

        AppRouter.appRouter.pushReplacement(AllCategoriesCustomerScreen());
      }
    }
  }

  checkUser() async {
    User? user = AuthHelper.authHelper.getLoggedUser();
    await Future.delayed(Duration(seconds: 3));
    if (user != null) {
      loggedUser =
          await FirestorHelper.firestorHelper.getUserFromFirestore(user.uid);
      loggedUser!.email = user.email;
      log(loggedUser!.name!);

      notifyListeners();
      AppRouter.appRouter.pushReplacement(AllCategoriesCustomerScreen());
    } else {
      AppRouter.appRouter.pushReplacement(SignIn());
    }
  }

  checkUserInit() async {
    User? user = AuthHelper.authHelper.getLoggedUser();
    await Future.delayed(Duration(seconds: 3));
    if (user != null) {
      loggedUser =
          await FirestorHelper.firestorHelper.getUserFromFirestore(user.uid);
      loggedUser!.email = user.email;

      notifyListeners();
    }
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRouter.appRouter.pushReplacement(AllCategoriesCustomerScreen());
  }

  uploadNewFile() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(pickedFile!.path);
    String uploadedImage =
        await StorageHelper.storageHelper.uploadNewImage('user_images', file);
    loggedUser!.imageURL = uploadedImage;
    await FirestorHelper.firestorHelper.updateUser(loggedUser!);
    notifyListeners();
  }
}
