import 'package:firebase_app/auth/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).checkUser();
    return Scaffold(body: Center(child: FlutterLogo()));
  }
}
