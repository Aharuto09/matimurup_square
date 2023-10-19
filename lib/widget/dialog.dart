import 'package:flutter/material.dart';
import 'package:matimurup_square/widget/button.dart';

class TDialog extends StatelessWidget {
  TDialog(
      {super.key,
      required this.title,
      required this.body,
      required this.button});
  String title, body, button;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          height: 180,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(body),
              Align(
                alignment: Alignment.centerRight,
                child: TButton(
                  label: button,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )),
    );
  }
}

class GDialog extends StatelessWidget {
  GDialog({super.key, required this.title, required this.body});
  String title, body;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          height: 180,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(body),
              SizedBox(height: 30)
            ],
          )),
    );
  }
}
