import 'package:eye/widgets/appBar.dart';
import 'package:flutter/material.dart';

class friends extends StatefulWidget {
  const friends({super.key});

  @override
  State<friends> createState() => _friendsState();
}

class _friendsState extends State<friends> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "الأصدقاء", context: context, icon: Icons.arrow_back_ios),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 5),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset(
            "assets/friends.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
