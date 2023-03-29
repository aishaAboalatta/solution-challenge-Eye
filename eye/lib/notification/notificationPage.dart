import 'package:eye/notification/matchForm.dart';
import 'package:eye/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({super.key});

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "الإشعارات", context: context, icon: Icons.arrow_back_rounded),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 5),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const matchForm(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
              );
            },
            child: Image.asset(
              alignment: Alignment.topCenter,
              "assets/notification.png",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
