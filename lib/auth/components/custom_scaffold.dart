import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/components/custom_appbar_bottom.dart';
import 'package:firebase_app/auth/components/custom_drawer.dart';
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
          actions: actions,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: floatingActionButton,
        drawer: AppRouter.appRouter.canPop() ? null : CustomDrawer(),
        body: body,
      ),
    );
  }
}
