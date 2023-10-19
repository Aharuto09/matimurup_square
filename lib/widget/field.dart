import 'package:flutter/material.dart';

class TField extends StatelessWidget {
  // TField({super.key, required this.controller, required this.label});
  TField(
      {super.key,
      required this.controller,
      required this.label,
      this.inputNum = false});
  TextEditingController controller;
  String label;
  bool inputNum;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            filled: true,
            fillColor: Colors.deepPurple.withOpacity(0.2)),
        keyboardType: (inputNum) ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
