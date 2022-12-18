import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  String? value, hint;
  Function? onChanged;
  CustomDropDownButton(
      {Key? key, this.value, this.onChanged, required this.values, this.hint})
      : super(key: key);

  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton(
        hint: Text(hint ?? ''),
        value: value,
        items: values.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          onChanged!(value);
        },
      ),
    );
  }
}
