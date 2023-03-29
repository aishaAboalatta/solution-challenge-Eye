import 'package:eye/widgets/appBar.dart';
import 'package:flutter/material.dart';

class matchForm extends StatefulWidget {
  const matchForm({super.key});

  @override
  State<matchForm> createState() => _matchFormState();
}

class _matchFormState extends State<matchForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "التحقق من تطابق بلاغ",
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
              "assets/matchForm.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
