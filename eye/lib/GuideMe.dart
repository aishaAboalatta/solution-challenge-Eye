// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/imageDetection/imageDetection.dart';
import 'package:eye/widgets/appBar.dart';
import 'package:eye/widgets/appBarHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'notification/LocalNotificationService.dart';
import 'notification/notify.dart';
import 'register/user_information_screen.dart';

class GuideMe extends StatefulWidget {
  const GuideMe({super.key});

  @override
  State<GuideMe> createState() => _GuideMeState();
}

class _GuideMeState extends State<GuideMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarHome(
          title: "أرشدني",
          context: context,
          photo: "no",
          icon: Icons.question_mark_rounded,
          isBottom: true),
      body: Center(
        child: Column(
          children: [Container()],
        ),
      ),
    );
  }

  GestureDetector guideMeCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 70,
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
        child: Row(
            //Icon

            //Text
            ),
      ),
    );
  }
}
