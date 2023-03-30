import 'package:eye/widgets/appBar.dart';
import 'package:flutter/material.dart';

class police extends StatefulWidget {
  const police({super.key});

  @override
  State<police> createState() => _policeState();
}

class _policeState extends State<police> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "مراكز بلاغات قريبة",
          context: context,
          icon: Icons.arrow_back_rounded),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 5),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: GestureDetector(
            child: Image.asset(
              alignment: Alignment.topCenter,
              "assets/police.png",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
