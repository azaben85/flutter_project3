import 'dart:ffi';

import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/add_new_slider.dart';
import 'package:firebase_app/admin/views/screens/car_displays_all.dart';
import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/admin/views/screens/my_car_list.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/auth_provider/auth_provider.dart';
import 'package:firebase_app/customer/customer_main_screen.dart';
import 'package:firebase_app/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    User? user = AuthHelper.authHelper.getLoggedUser();
    return Drawer(
      child: ListView(children: [
        Consumer<AuthProvider>(builder: (context, provider, child) {
          if (user == null)
            return const DrawerHeader(
                padding: EdgeInsets.only(top: 16),
                child: Center(child: Text('Select Option')));
          return UserAccountsDrawerHeader(
              accountName: Text(provider.loggedUser?.name ?? ''),
              accountEmail: Text(provider.loggedUser?.email ?? ''));
        }),
        InkWell(
            onTap: () {
              AppRouter.appRouter.pop();
              AppRouter.appRouter.push(const DisplayCars());
            },
            child: Row(
              children: const [
                Icon(Icons.car_repair_outlined),
                Text('Cars'),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        InkWell(
            onTap: () {
              AppRouter.appRouter.pop();
              AppRouter.appRouter.push(DisplayMyListCars());
            },
            child: Row(
              children: const [
                Icon(Icons.favorite),
                Text('My Favorite Cars'),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        InkWell(
            onTap: () {
              AppRouter.appRouter.pop();
              AppRouter.appRouter.push(AllCategoriesScreen());
            },
            child: Row(
              children: const [
                Icon(Icons.category),
                Text('Display Categories'),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        InkWell(
            onTap: () {
              AppRouter.appRouter.pop();
              AppRouter.appRouter.push(AddNewSlider());
            },
            child: Row(
              children: const [
                Icon(Icons.image),
                Text('Manage Sliders'),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        if (user == null)
          InkWell(
              onTap: () {
                Provider.of<CarProvider>(context, listen: false).getAllMyList();
                AppRouter.appRouter.pop();
                AppRouter.appRouter.push(SignIn());
              },
              child: Row(
                children: const [
                  Icon(Icons.login),
                  Text('Sign In'),
                ],
              )),
        if (user != null)
          InkWell(
              onTap: () async {
                await AuthHelper.authHelper.signOut();
                AppRouter.appRouter.pushReplacement(CustomerMainScreen());
              },
              child: Row(
                children: const [
                  Icon(Icons.logout),
                  Text('Sign Out'),
                ],
              )),
      ]),
    );
  }
}
