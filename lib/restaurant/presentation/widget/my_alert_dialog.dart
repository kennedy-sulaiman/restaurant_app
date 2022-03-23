import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String message;
  final String title;
  final CoolAlertType coolAlertType;
  const MyAlertDialog(
      {Key? key,
      required this.message,
      required this.title,
      required this.coolAlertType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
