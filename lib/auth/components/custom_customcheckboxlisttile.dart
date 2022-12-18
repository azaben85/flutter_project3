import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  bool? value;
  Function? onChnaged;
  String? label;
  CustomCheckboxListTile(
      {required this.value, required this.onChnaged, this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CheckboxListTile(
        title: Text(label ?? ''),
        value: value ?? false,
        onChanged: (value) {
          onChnaged!(value ?? false);
        },
      ),
    );
  }
}
