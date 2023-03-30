// ignore_for_file: prefer_const_constructors
import 'package:eye/police.dart';
import 'package:eye/widgets/appBarHome.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'constants/colors.dart';

class GuideMe extends StatefulWidget {
  const GuideMe({super.key});

  @override
  State<GuideMe> createState() => _GuideMeState();
}

class _GuideMeState extends State<GuideMe> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarHome(
            title: "أرشدني",
            context: context,
            photo: "no",
            icon: Icons.question_mark_rounded,
            isBottom: false),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  guideMeCard("assets/مركز بلاغات.png", "مراكز بلاغات قريبة"),
                  guideMeCard("assets/أرقام تهمك.png", "أرقام تهمك"),
                  guideMeCard("assets/فقدت شخص.png", "فقدت شخص"),
                  guideMeCard("assets/وجدت مفقود.png", "عثرت على مفقود"),
                  guideMeCard("assets/أدعية.png", "أدعية لمن فقد شيئًا"),
                  guideMeCard("assets/تواصل معنا.png", "تواصل معنا"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector guideMeCard(String photo, String title) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: police(), //page name here
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.slideUp,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(10),
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: primaryDarkGrean,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        //------------------------------------------------------
        child: Row(
          children: [
            //photo--------------------------
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(photo), fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            //Text----------------------------
            Text(
              title,
              style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  color: primaryDarkGrean,
                  height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
