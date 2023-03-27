import 'package:flutter/material.dart';
import '../../constants/colors.dart';

AppBar appBar(
    {required String title,
    required BuildContext context,
    required IconData icon,
    bool dialog = false,
    String text = "",
    String option = "",
    String photo = ""}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: white,
        //fontFamily: "Almarai",
      ),
    ),
    leading: IconButton(
      padding: const EdgeInsets.only(right: 20),
      icon: Icon(
        icon,
        color: white,
        size: 30.0,
      ),
      onPressed: () {
        if (dialog) {
          dialogClose(text, context, photo, option);
        } else {
          Navigator.pop(context);
        }
      },
    ),
    backgroundColor: primaryDarkGrean,
    shadowColor: primaryDarkGrean,
    elevation: 3,
    centerTitle: false,
  );
}

dialogClose(text, context1, photo, option) {
  return showDialog(
      context: context1,
      builder: (BuildContext context) {
        //Delete Form
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Center(
            child: Text(
              "تنبيه",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 221, 112, 112),
                fontFamily: "Almarai",
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 280,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage(photo),
                  )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                      height: 1.5),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("تراجع"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(option,
                  style: const TextStyle(
                    color: Colors.red,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context1);
              },
            )
          ],
        );
      });
}
