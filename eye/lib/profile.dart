import 'package:eye/constants/colors.dart';
import 'package:eye/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "الملف الشخصي", context: context, icon: Icons.arrow_back),
      body: Column(
        children: [
          //زر التعديل
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                // route to edit page
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
              image: const DecorationImage(
                image: ExactAssetImage('assets/profile_test.png'),
              ),
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
          const Text(
            "ماجدة أحمد عبدالغني",
            textAlign: TextAlign.center,
            style: TextStyle(
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
            children: const [
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.phone,
                color: primaryDarkGrean,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "+20106747489",
                style: TextStyle(
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
            children: const [
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.email,
                color: primaryDarkGrean,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "felicia.reid@example.com",
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
              //route to friends page
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
      ),
    );
  }
}
