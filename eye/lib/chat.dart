import 'package:eye/widgets/appBar.dart';
import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "المحادثات", context: context, icon: Icons.arrow_back_ios),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              alignment: Alignment.topCenter,
              "assets/chat3.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
