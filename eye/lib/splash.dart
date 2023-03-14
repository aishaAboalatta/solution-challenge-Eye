import 'dart:async';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:eye/widgets/navBar.dart';
import 'package:flutter/material.dart';

//Here is the splash screen
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /* @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const navBar())));
  }*/

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: const Color(0x91fefae0),
        duration: const Duration(milliseconds: 5000),
        animationDuration: const Duration(milliseconds: 3000),
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: Stack(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 186,
              height: 186,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Color(0x77d36b00),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(186)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/logo2.png",
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 186,
              height: 186,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Color(0xad2c4339),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(186)),
              ),
            ),
          )
        ]),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        defaultNextScreen: const navBar(),
      ),
    );
  }
}
