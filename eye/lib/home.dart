import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/widgets/appBarHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'notification/LocalNotificationService.dart';
import 'notification/notify.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String userName = "";
  String userPhoto = "";
  late final LocalNotificationService service;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String userId = user!.uid;
    setUserName(userId);
    setUserPhoto(userId);
    service = LocalNotificationService();
    service.intialize();
    listenToDB(service);
    //listenToNotification(service);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String userId = user!.uid;
    setUserName(userId);
    setUserPhoto(userId);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarHome(title: userName, context: context, photo: userPhoto),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset(
            alignment: Alignment.topCenter,
            "assets/home.png",
            fit: BoxFit.scaleDown,
          ),
        ),
      ),

      /* Center(
        child: GestureDetector(
            onTap: () {
              meth('a10.jpeg', 'a11.jpeg');
            },
            child: Container(
              height: 30,
              width: 30,
              color: Colors.black,
            )),
  
      ),*/
    );
  }

  Future<void> setUserName(String userId) async {
    String existedName = await getName(userId);
    if (existedName != "") {
      setState(() {
        userName = existedName;
      });
    } else {
      setState(() {
        userName = "مرحبا";
      });
    }
  }

  Future<void> setUserPhoto(String userId) async {
    String existedPhoto = await getPhoto(userId);
    if (existedPhoto != "") {
      setState(() {
        userPhoto = existedPhoto;
      });
    } else {
      setState(() {
        userPhoto = "no";
      });
    }
  }

  Future<String> getName(String userId) async {
    String userName = "";
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var data = userDoc.data() as Map;
    userName = data["name"];
    return userName;
  }

  Future<String> getPhoto(String userId) async {
    String userPhoto = "";
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var data = userDoc.data() as Map;
    userPhoto = data["profilePic"];
    return userPhoto;
  }
}
