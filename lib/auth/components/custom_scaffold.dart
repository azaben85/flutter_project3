import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/admin/views/screens/display_categories_customer.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_helper.dart';
import 'package:firebase_app/auth/components/custom_appbar_bottom.dart';
import 'package:firebase_app/auth/components/custom_drawer.dart';
import 'package:firebase_app/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  String? title;
  Widget? body;
  List<Widget>? actions;
  Widget? floatingActionButton;
  String? bottomTitle;
  CustomScaffold({
    this.bottomTitle,
    Key? key,
    this.title,
    this.body,
    this.floatingActionButton,
    this.actions,
  }) : super(key: key);
  User? user = AuthHelper.authHelper.getLoggedUser();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            title ?? '',
          ),
          bottom: bottomTitle != null
              ? CustomBottomAppBar(
                  title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    bottomTitle!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ))
              : null,
          actions: [
            if (user == null)
              InkWell(
                  onTap: () {
                    AppRouter.appRouter.push(SignIn());
                  },
                  child: Icon(Icons.login)),
            if (user != null)
              InkWell(
                  onTap: () async {
                    await AuthHelper.authHelper.signOut();
                    AppRouter.appRouter
                        .pushReplacement(AllCategoriesCustomerScreen());
                  },
                  child: Icon(Icons.logout)),
            ...actions ?? []
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: floatingActionButton,
        body: body,
      ),
    );
  }
}
