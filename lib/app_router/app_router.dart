import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();
  static AppRouter appRouter = AppRouter._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  pushReplacement(Widget screen) {
    navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (notNeededContext) {
      return screen;
    }));
  }

  push(Widget screen) {
    navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (notNeededContext) {
      return screen;
    }));
  }

  pop() {
    navigatorKey.currentState!.pop();
  }

  showCustomDialog(String title, String content) {
    showDialog(
      useSafeArea: true,
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }

  showProgressBar() {
    showDialog(
      useSafeArea: true,
      context: navigatorKey.currentContext!,
      builder: (context) {
        return const AlertDialog(
          //title: Text(title),
          content: LinearProgressIndicator(minHeight: 25),
        );
      },
    );
  }
}
