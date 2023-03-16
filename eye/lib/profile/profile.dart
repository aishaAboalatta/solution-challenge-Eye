import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/constants/colors.dart';
import 'package:eye/profile/editProfile.dart';
import 'package:eye/splash.dart';
import 'package:eye/widgets/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../register/provider/auth_provider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late String userId;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    setState(() {
      userId = user!.uid;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "الملف الشخصي", context: context, icon: Icons.arrow_back),
      body: StreamBuilder(
          stream: readUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('somting wrong \n ${snapshot.error}');
            } else if (snapshot.hasData) {
              final userInfo = snapshot.data!;
              return Column(
                children: [
                  //زر التعديل
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        // route to edit page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editProfile(
                                      ImageUrl:
                                          NetworkImage(userInfo['profilePic']),
                                      email: userInfo['email'],
                                      name: userInfo['name'],
                                      phone: userInfo['phoneNumber'],
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: primaryDarkGrean,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                  //صورة البروفايل
                  Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    width: 141,
                    height: 141,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(userInfo['profilePic']),
                          fit: BoxFit.cover),
                      color: white,
                      border: Border.all(
                        color: primaryDarkGrean,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  //الاسم
                  Text(
                    userInfo['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: primaryDarkGrean,
                      fontSize: 20,
                      fontFamily: "Almarai",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  //مسافة
                  const SizedBox(
                    height: 40,
                  ),
                  //رقم الهاتف
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.phone,
                        color: primaryDarkGrean,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        userInfo['phoneNumber'],
                        style: const TextStyle(
                          color: Color(0xff2c4339),
                          fontSize: 17,
                          fontFamily: "Almarai",
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  //مسافة
                  const SizedBox(
                    height: 5,
                  ),
                  //الايميل
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.email,
                        color: primaryDarkGrean,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        userInfo['email'],
                        style: TextStyle(
                          color: Color(0xff2c4339),
                          fontSize: 17,
                          fontFamily: "Almarai",
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  //خط افقي
                  const Divider(
                    height: 30,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: primaryDarkGrean,
                  ),
                  //الاصدقاء
                  GestureDetector(
                    onTap: () {
                      //route to friends page
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.person,
                          color: primaryDarkGrean,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "الأصدقاء",
                          style: TextStyle(
                            color: Color(0xff2c4339),
                            fontSize: 20,
                            fontFamily: "Almarai",
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  //خط افقي
                  const Divider(
                    height: 30,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: primaryDarkGrean,
                  ),
                  //الإعدادات
                  GestureDetector(
                    onTap: () {
                      //route to friends page
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          CupertinoIcons.gear_alt_fill,
                          color: primaryDarkGrean,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "الإعدادات",
                          style: TextStyle(
                            color: Color(0xff2c4339),
                            fontSize: 20,
                            fontFamily: "Almarai",
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  //خط افقي
                  const Divider(
                    height: 30,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: primaryDarkGrean,
                  ),
                  //تسجيل الخروج
                  GestureDetector(
                    onTap: () {
                      //logout
                      ap.userSignOut().then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Splash(),
                              ),
                            ),
                          );
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "تسجيل الخروج",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontFamily: "Almarai",
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  /* Stream<List<UserModel>> readUserInfo() => FirebaseFirestore.instance
      .collection('users')
      .where("id", isEqualTo: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());*/

  Stream readUserInfo() => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get()
      .asStream();
}
