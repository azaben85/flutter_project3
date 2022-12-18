import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/providers/car_provider.dart';
import 'package:firebase_app/admin/views/screens/main_admin_screen.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_provider/auth_provider.dart';
import 'package:firebase_app/customer/customer_main_screen.dart';
import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_app/maps/custom_map.dart';
import 'package:firebase_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
ecommerce app
users:
1- admin user
add/update/delete product
display orders all
display all products
accept /reject orders

2 - customer user
display all products
add/remove product to cart/ edit product QTY in cart
checkout
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) {
          return AuthProvider();
        },
      ),
      ChangeNotifierProvider<AdminProvider>(
        create: (context) {
          return AdminProvider();
        },
      ),
      ChangeNotifierProvider<CarProvider>(
        create: (context) {
          return CarProvider();
        },
      ),
    ], child: InitApp());
  }
}

class InitApp extends StatelessWidget {
  const InitApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: AppRouter.appRouter.navigatorKey,
        // theme: Provider.of<ToDoClassProvider>(context).isDarkMode
        //     ? ThemeData.dark()
        //     : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        title: 'ToDo APP',
        home: CustomerMainScreen());
  }
}
