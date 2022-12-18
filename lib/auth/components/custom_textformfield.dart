import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function validation;
  Function? onSave;
  String label;
  TextEditingController? inputController;
  bool? isPassword;
  TextInputType inputType;
  CustomTextField({
    this.inputType = TextInputType.text,
    this.isPassword = false,
    Key? key,
    this.inputController,
    required this.validation,
    this.onSave,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (inputController != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: inputType,
          obscureText: isPassword!,
          controller: inputController,
          validator: (v) => validation(v),
          decoration: InputDecoration(hintText: label),
        ),
      );
    }
    return TextFormField(
      obscureText: isPassword!,
      validator: (v) => validation(v),
      onSaved: (v) => onSave!(v),
      decoration: InputDecoration(hintText: label),
    );
  }
}
