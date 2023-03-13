import 'package:flutter/material.dart';
import '../../constants/colors.dart';

AppBar appBar({
  required String title,
  required BuildContext context,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: white,
        //fontFamily: "Tajawal",
      ),
    ),
    leading: IconButton(
      padding: const EdgeInsets.only(right: 20),
      icon: const Icon(
        Icons.close_rounded,
        color: white,
        size: 30.0,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: primaryDarkGrean,
    shadowColor: primaryDarkGrean,
    elevation: 3,
    centerTitle: false,
  );
}
