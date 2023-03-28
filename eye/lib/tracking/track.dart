import 'package:eye/widgets/appBarHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class track extends StatefulWidget {
  const track({super.key});

  @override
  State<track> createState() => _trackState();
}

class _trackState extends State<track> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarHome(
          title: "تتبعني",
          context: context,
          photo: "no",
          icon: CupertinoIcons.placemark,
          isBottom: true),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              alignment: Alignment.topCenter,
              "assets/tracking.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
