// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
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
        // appBar: appBarHome(
        //     title: "أرشدني",
        //     context: context,
        //     photo: "no",
        //     icon: Icons.question_mark_rounded,
        //     isBottom: true),
        body: Container(
          //*ما ضبط معاي الاب بار، يمكن لأنه أجرب من خارج التطبيق، لما يضبط نتحكم في المارجن
          margin: EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              children: [
                guideMeCard("assets/مركز بلاغات.png", "مركز بلاغات قريبة"),
                guideMeCard("assets/أرقام تهمك.png", "أرقام تهمك"),
                guideMeCard("assets/فقدت شخص.png", "فقدت شخص"),
                guideMeCard("assets/وجدت مفقود.png", "وجدت مفقود"),
                guideMeCard("assets/أدعية.png", "أدعية لمن فقد شيئًا"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector guideMeCard(String photo, String title) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(10),
        height: 100,
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
