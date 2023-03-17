import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/widgets/appBarHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String userName = "";
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String userId = user!.uid;
    setUserName(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarHome(title: userName, context: context),
      body: Center(),
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

  Future<String> getName(String userId) async {
    String userName = "";
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var data = userDoc.data() as Map;
    userName = data["name"];
    return userName;
  }
}
