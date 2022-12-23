import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_provider/auth_provider.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';
import 'package:firebase_app/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return CustomScaffold(
        title: 'Sign In',
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: provider.signInKey,
            child: ListView(
              children: [
                CustomTextField(
                  inputType: TextInputType.emailAddress,
                  validation: provider.validateEmail,
                  inputController: provider.loginEmail,
                  label: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  isPassword: true,
                  validation: provider.validatePassword,
                  inputController: provider.passwordController,
                  label: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await provider.signIn();
                    },
                    child: const Text('Sign In')),
                ElevatedButton(
                    onPressed: () {
                      provider.clearFields();
                      AppRouter.appRouter.pushReplacement(SignUp());
                    },
                    child: const Text('Sign Up With Email'))
              ],
            ),
          ),
        ),
      );
    });
  }
}
