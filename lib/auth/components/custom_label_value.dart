import 'dart:developer';

import 'package:flutter/material.dart';

class LabelValue extends StatelessWidget {
  String label;
  String? value;
  int? index;
  LabelValue(this.label, [this.value = '', this.index = 1]);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        color: (index ?? 1) % 2 == 0 ? Colors.green[50] : Colors.green[100],
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Expanded(
              child: Text(
                value!,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
