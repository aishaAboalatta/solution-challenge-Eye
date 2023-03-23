// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GameGuide extends StatefulWidget {
  const GameGuide({super.key});

  @override
  State<GameGuide> createState() => _GameGuideState();
}

class _GameGuideState extends State<GameGuide> {
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 60),
        child: PageView(
          controller: controller,
          children: [
            Container(color: Colors.red, child: Center(child: Text("one"))),
            Container(color: Colors.green, child: Center(child: Text("two"))),
            Container(color: Colors.blue, child: Center(child: Text("three")))
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text("تجاهل"),
              onPressed: () {
                //should open the first level
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameGuide()),
                );
              },
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                    activeDotColor: Colors.green,
                    dotColor: Color.fromARGB(255, 184, 184, 184)),
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              child: Text("التالي"),
            ),
          ],
        ),
      ),
    );
  }
}
