import 'package:flutter/material.dart';

class CheckboxDisplay extends StatelessWidget {
  String label;
  bool condition;
  CheckboxDisplay(
    this.condition,
    this.label,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (condition)
          const Icon(
            Icons.radio_button_on,
            size: 20,
            color: Colors.green,
          )
        else
          const Icon(
            Icons.radio_button_off,
            size: 20,
            color: Colors.grey,
          ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
