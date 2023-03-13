import 'package:flutter/material.dart';
import '../../constants/colors.dart';

AppBar appBarHome({required String title, required BuildContext context}) {
  return AppBar(
    actions: [
      InkWell(
        child: const SizedBox(
          width: 45,
          child: Icon(
            Icons.chat,
            color: white,
            size: 25.0,
          ),
        ),
        onTap: () {},
      ),
      InkWell(
        child: const SizedBox(
          width: 45,
          child: Icon(
            Icons.notifications,
            color: white,
            size: 30.0,
          ),
        ),
        onTap: () {},
      ),
      const SizedBox(
        width: 10,
      ),
    ],
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
        Icons.account_circle,
        color: white,
        size: 40.0,
      ),
      onPressed: () {},
    ),
    backgroundColor: primaryDarkGrean,
    shadowColor: primaryDarkGrean,
    elevation: 3,
    centerTitle: false,
  );
}
