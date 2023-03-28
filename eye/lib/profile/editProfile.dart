import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/profile/profile.dart';
import 'package:eye/widgets/appBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../location/currentLocation.dart';
import '../widgets/toastMssg.dart';
import '../widgets/utils/utils.dart';

class editProfile extends StatefulWidget {
  var ImageUrl, name, phone, email, id, loc;
  editProfile(
      {super.key,
      required this.ImageUrl,
      required this.name,
      required this.phone,
      required this.email,
      required this.id,
      required this.loc});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  var _uid;
  File? image;
  String downloadUrl = "";
  bool complateUpload = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameinput = TextEditingController();
  TextEditingController phoneinput = TextEditingController();
  TextEditingController emailinput = TextEditingController();
  final locationController = TextEditingController();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    _uid = widget.phone;
    nameinput.text = widget.name;
    phoneinput.text = widget.phone;
    emailinput.text = widget.email;
    locationController.text = widget.loc;
    super.initState();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  // for selecting image
  void selectImageCam() async {
    image = await pickImageCam(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
            title: "تعديل الملف الشخصي",
            context: context,
            icon: Icons.close_rounded,
            dialog: true,
            text: "ستفقد ما قمت بإضافته \n هل أنت متأكد؟",
            photo: "assets/erase.png",
            option: "نعم"),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                //الصورة
                Center(
                  child: Stack(
                    children: <Widget>[
                      image == null
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 7, top: 43),
                              width: 141,
                              height: 141,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: widget.ImageUrl, fit: BoxFit.cover),
                                color: white,
                                border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
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
                            )
                          : Container(
                              margin: const EdgeInsets.only(bottom: 7, top: 43),
                              width: 141,
                              height: 141,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover),
                                color: white,
                                border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
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
                      //زر التعديل على الصورة
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              showPhotoDialog();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: primaryDarkGrean,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //الاسم
                formField(nameinput, "الاسم", Icons.pin, TextInputType.name,
                    validName, 30, 1, false),
                //رقم الهاتف
                formField(phoneinput, "رقم الهاتف", Icons.phone,
                    TextInputType.datetime, null, 13, 1, true,
                    fillColor: Colors.grey.shade300),
                //الايميل
                formField(emailinput, "البريد الإلكتروني", Icons.email,
                    TextInputType.emailAddress, validEmail, 40, 1, false),
                //الموقع
                locationFeild(
                    hintText: "اضغط لتعديل الموقع",
                    icon: Icons.pin_drop_rounded,
                    inputType: TextInputType.name,
                    maxLines: 3,
                    controller: locationController,
                    context: context),
                //submit
                const SizedBox(
                  height: 10,
                ),
                submitBttn(),
              ],
            ),
          ),
        ));
  }

  String? validName(value) {
    if (value!.trim() == null || value.trim().isEmpty) {
      return 'أدخل اسم لا يقل عن حرفين';
    }
    if (!RegExp(
            r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- ][]*$")
        .hasMatch(value)) {
      return "أدخل اسم بلا أرقام ورموز";
    }

    return null;
  }

  String? validEmail(value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z]+\.[a-zA-Z]+$)';
    // final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'أدخل البريد الإلكتروني';
    } else if (!regExp.hasMatch(value)) {
      return 'أدخل بريد إلكتروني صحيح';
    } else {
      return null;
    }
  }

  Future<void> showPhotoDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Center(
              child: SimpleDialogOption(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: primaryDarkGrean,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'من ألبوم الصور',
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: primaryDarkGrean,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  selectImage();
                },
              ),
            ),
            Center(
              child: SimpleDialogOption(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  decoration: BoxDecoration(
                    color: primaryDarkGrean,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "من الكاميرا",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  selectImageCam();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget formField(
      TextEditingController controll,
      String title,
      IconData icon,
      TextInputType input,
      String? Function(String?)? validation,
      int maxLen,
      int maxLine,
      bool read,
      {Color fillColor = Colors.white}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        readOnly: read,
        controller: controll,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: input,
        maxLength: maxLen,
        maxLines: maxLine,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: title,
          suffix: Icon(
            icon,
            color: primaryDarkGrean,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          labelStyle:
              const TextStyle(color: primaryDarkGrean, fontFamily: "Almarai"),
          fillColor: fillColor,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryDarkGrean),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: primaryDarkGrean),
          ),
          errorStyle: const TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
          ),
        ),
        validator: validation,
      ),
    );
  }

  Widget submitBttn() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            FocusScope.of(context).unfocus();
            if (image != null) {
              storeFileToStorage("profilePic/${widget.id}", image!);
            } else {
              setState(() {
                complateUpload = true;
              });
              final userUpdated =
                  FirebaseFirestore.instance.collection('users').doc(widget.id);
              userUpdated.update({
                'name': nameinput.text,
                'email': emailinput.text,
              });
            }
            if (complateUpload) {
              Future.delayed(const Duration(seconds: 1), () {
                showToast("تم تعديل الملف الشخصي بنجاح");
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
                //Navigator.pop(context);
              });
            } else {
              showSnackBar(context, "الرجاء الانتظار يتم تحميل الصورة");
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryDarkGrean),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: const Text(
          "تعديل",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Almarai",
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  void storeFileToStorage(String ref, File file) async {
    String Url = "";
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    await snapshot.ref.getDownloadURL().then((value) {
      Url = value;
      final userUpdated =
          FirebaseFirestore.instance.collection('users').doc(widget.id);
      userUpdated.update({
        'name': nameinput.text,
        'email': emailinput.text,
        'profilePic': Url,
        'location': locationController.text
      }).whenComplete(() {
        setState(() {
          complateUpload = true;
        });
        showSnackBar(context, "تم تحميل الصورة بنجاح");
      });
    });
  }
}
