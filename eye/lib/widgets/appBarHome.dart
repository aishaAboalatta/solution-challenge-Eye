import 'package:eye/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../constants/colors.dart';

AppBar appBarHome(
    {required String title,
    required BuildContext context,
    required String photo}) {
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
    leading: photo == "no"
        ? IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.account_circle,
              color: white,
              size: 40.0,
            ),
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const profile(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
              );
            },
          )
        : GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const profile(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(photo), fit: BoxFit.cover),
                color: white,
                shape: BoxShape.circle,
              ),
            ),
          ),
    backgroundColor: primaryDarkGrean,
    shadowColor: primaryDarkGrean,
    elevation: 3,
    centerTitle: false,
  );
}
