import 'package:flutter/material.dart';

class TButton extends StatelessWidget {
  TButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isWhite = false});
  String label;
  Function() onPressed;
  bool isWhite;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isWhite ? Colors.white : Colors.deepPurple),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
          elevation: MaterialStateProperty.all(10),
          minimumSize: MaterialStateProperty.all(const Size(60, 60)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ))),
      child: Text(
        label,
        style: TextStyle(color: isWhite ? Colors.deepPurple : Colors.white),
      ),
    );
  }
}
