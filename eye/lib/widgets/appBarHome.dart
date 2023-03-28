import 'package:eye/notification/notificationPage.dart';
import 'package:eye/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../constants/colors.dart';
import '../chat.dart';

AppBar appBarHome(
    {required String title,
    required BuildContext context,
    required String photo,
    IconData icon = Icons.account_circle,
    bool isBottom = false}) {
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
        onTap: () {
          if (photo != "no") {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: chat(), //page name here
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
            );
          }
        },
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
        onTap: () {
          if (photo != "no") {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: notificationPage(), //page name here
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
            );
          }
        },
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
        //fontFamily: "Almarai",
      ),
    ),
    leading: photo == "no"
        ? Padding(
            //it was iconButton
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              icon,
              color: white,
              size: 40.0,
            ),
            /*  onPressed: () {
                   PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const profile(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
              );
            },*/
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
    bottom: isBottom
        ? const TabBar(
            /*
            indicatorPadding: const EdgeInsets.all(5),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(65), // Creates border
                color: darkOrange),*/
            //indicatorColor: darkOrange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: white,
            labelColor: Colors.white,
            indicatorWeight: 5,
            tabs: <Widget>[
              Tab(
                text: "فقدت",
              ),
              Tab(
                text: "وجدت",
              ),
            ],
          )
        : null,
  );
}
