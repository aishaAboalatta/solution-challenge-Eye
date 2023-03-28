import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/constants/colors.dart';
import 'package:eye/model/loseFormModel.dart';
import 'package:eye/myForms/editMyForms.dart';
import 'package:eye/widgets/appBarHome.dart';
import 'package:eye/widgets/toastMssg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../model/findFormModel.dart';
import 'package:url_launcher/url_launcher.dart';

class myForms extends StatefulWidget {
  const myForms({super.key});

  @override
  State<myForms> createState() => _myFormsState();
}

class _myFormsState extends State<myForms> {
  String userId = "";

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
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarHome(
            title: "بلاغاتي",
            context: context,
            photo: "no",
            icon: Icons.history,
            isBottom: true),
        body: TabBarView(
          children: [
            StreamBuilder<List<loseFormModel>>(
                stream: readLoseForms(),
                builder: (context, snapshot) {
                  List<loseFormModel> loseForms;
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final data = snapshot.data!;

                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا يوجد لديك بلاغات فقد',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      loseForms = data.toList();

                      return ListView.builder(
                        itemCount: loseForms.length,
                        itemBuilder: (context, index) {
                          Color stateColor;
                          if (loseForms[index].state == "تم العثور") {
                            stateColor = findColor;
                          } else {
                            stateColor = lostColor;
                          }

                          return formCard(
                              loseForms[index].photo,
                              loseForms[index].name,
                              loseForms[index].age,
                              stateColor,
                              loseForms[index].state,
                              "تاريخ الفقد: ${loseForms[index].date}",
                              "loseForm",
                              loseForms[index].id,
                              loseForms[index].time,
                              loseForms[index].description,
                              loseForms[index].location);
                        },
                      );
                    }
                  }
                }),
            StreamBuilder<List<findFormModel>>(
                stream: readFindForms(),
                builder: (context, snapshot) {
                  List<findFormModel> findForms;
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final data = snapshot.data!;

                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا يوجد لديك بلاغات عثور',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      findForms = data.toList();

                      return ListView.builder(
                        itemCount: findForms.length,
                        itemBuilder: (context, index) {
                          Color stateColor;
                          if (findForms[index].state == "تم العثور") {
                            stateColor = findColor;
                          } else {
                            stateColor = lostColor;
                          }

                          return formCard(
                              findForms[index].photo,
                              findForms[index].name,
                              findForms[index].age,
                              stateColor,
                              findForms[index].state,
                              "تاريخ العثور: ${findForms[index].date}",
                              "findForm",
                              findForms[index].id,
                              findForms[index].time,
                              findForms[index].description,
                              findForms[index].location);
                        },
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Stream<List<loseFormModel>> readLoseForms() {
    return FirebaseFirestore.instance
        .collection('loseForm')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => loseFormModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<findFormModel>> readFindForms() {
    return FirebaseFirestore.instance
        .collection('findForm')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => findFormModel.fromJson(doc.data()))
            .toList());
  }

  Widget formCard(
      photo, name, age, colo, state, date, type, id, time, desc, loc) {
    return GestureDetector(
      onTap: () {
        //show details
        showDetails(photo, name, age, state, date, time, desc, loc);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 118,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: primaryDarkGrean,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //الصورة
            Row(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 102,
                    height: 101,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(photo), fit: BoxFit.cover),
                      color: const Color(0xffd9d9d9),
                      border: Border.all(
                        color: primaryDarkGrean,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //الاسم
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Almarai",
                          color: Colors.black,
                          height: 1.5),
                    ),

                    Row(
                      children: [
                        /* const Icon(
                          Icons.calendar_view_day,
                          color: Colors.black,
                          size: 13,
                        ),*/
                        Text(
                          "العمر: ${age}",
                          style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: "Almarai",
                              color: Colors.black,
                              height: 1.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        /*  const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                          size: 13,
                        ),*/
                        Text(
                          date,
                          style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: "Almarai",
                              color: Colors.black,
                              height: 1.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle_rounded,
                          color: colo,
                          size: 13.0,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          state,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Almarai",
                              color: colo,
                              height: 1.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  Icons.edit,
                  primaryDarkGrean,
                  "edit",
                  id,
                  type,
                  photo,
                  name,
                  age,
                  state,
                  date,
                  time,
                  desc,
                  loc,
                ),
                const SizedBox(
                  height: 10,
                ),
                button(Icons.delete, Color.fromARGB(255, 198, 32, 20), "delete",
                    id, type, photo, name, age, state, date, time, desc, loc),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button(
    IconData icon,
    color,
    option,
    id,
    type,
    photo,
    name,
    age,
    state,
    date,
    time,
    desc,
    loc,
  ) {
    return GestureDetector(
      onTap: () {
        if (option == "delete")
          deletForm(id, type);
        else {
          editForm(photo, name, age, state, date, time, desc, loc, type, id);
        }
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: color,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  deletForm(id, type) {
    return showDialog(
        context: context,
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
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: AssetImage('assets/delete.png'),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'سيتم حذف هذا البلاغ نهائياً',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
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
                child: const Text("حذف",
                    style: TextStyle(
                      color: Colors.red,
                    )),
                onPressed: () {
                  FirebaseFirestore.instance.collection(type).doc(id).delete();

                  Navigator.of(context).pop();
                  showToast("تم حذف البلاغ بنجاح");
                },
              )
            ],
          );
        });
  }

  editForm(photo, name, age, state, String date, time, desc, loc, type, id) {
    int dateOnly = date.indexOf(" ", 6);
    return PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: editMyForms(
          photo: photo,
          name: name,
          age: age.toString(),
          date: date
              .substring(dateOnly)
              .substring(1), //عشان نحذف تاريخ الفقد: (العنوان)
          time: time,
          loc: loc,
          desc: desc,
          type: type,
          id: id),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.slideRight,
    );
  }

  showDetails(photo, name, age, state, date, time, desc, loc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          //Delete Form
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Center(
              child: Text(
                "تفاصيل البلاغ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: darkOrange,
                  fontFamily: "Almarai",
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(photo),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "$name",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "العمر: $age",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "$date",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "الوقت: $time",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "الموقع: $loc",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Uri uri = Uri(
                        scheme: 'https',
                        host: 'maps.google.com',
                        path: '/?q=$loc');
                    urlLuncher(uri);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, right: 70),
                    alignment: Alignment.center,
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: lightYellow,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: lightYellow,
                    ),
                    child: const Text(
                      "عرض الموقع على الخريطة",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: darkOrange,
                        fontFamily: "Almarai",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "الوصف: $desc",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkGrean,
                      fontFamily: "Almarai",
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("إغلاق"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

Future<void> urlLuncher(Uri _url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
