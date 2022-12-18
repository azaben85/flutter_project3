import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/auth_provider/auth_provider.dart';
import 'package:firebase_app/auth/components/custom_textformfield.dart';
import 'package:firebase_app/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: provider.signUpKey,
            child: ListView(
              children: [
                CustomTextField(
                  validation: provider.validateText,
                  inputController: provider.nameController,
                  label: 'Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  inputType: TextInputType.phone,
                  validation: provider.validatePhome,
                  inputController: provider.phoneController,
                  label: 'Phone Number',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  inputType: TextInputType.emailAddress,
                  validation: provider.validateEmail,
                  inputController: provider.registerEmail,
                  label: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  validation: provider.validatePassword,
                  inputController: provider.passwordController,
                  isPassword: true,
                  label: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      provider.signUp();
                    },
                    child: const Text('Sign Up')),
                ElevatedButton(
                    onPressed: () async {
                      provider.clearFields();
                      AppRouter.appRouter.pushReplacement(SignIn());
                    },
                    child: const Text('Back'))
              ],
            ),
          ),
        ),
      );
    });
  }
}
