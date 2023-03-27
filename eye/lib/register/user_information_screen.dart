import 'dart:io';

import 'package:eye/constants/colors.dart';
import 'package:eye/register/register_screen.dart';
import 'package:eye/widgets/navBar.dart';
import 'package:flutter/material.dart';
import 'package:eye/model/user_model.dart';
import 'package:eye/register/provider/auth_provider.dart';
import 'package:eye/widgets/utils/utils.dart';
import 'package:eye/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../location/currentLocation.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: lightYellow,
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryDarkGrean,
                ),
              )
            : SingleChildScrollView(
                //padding:
                //const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                              (route) => false),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Icon(
                              Icons.close_rounded,
                              color: primaryDarkGrean,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "تسجيل حساب جديد",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: primaryDarkGrean),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? CircleAvatar(
                                backgroundColor: primaryDarkGrean,
                                radius: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "أضف صورة",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 60,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // name field
                            textFeld(
                                hintText: "الاسم",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                                validation: validName,
                                maxLen: 30),

                            // email
                            textFeld(
                                hintText: "البريد الإلكتروني",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: emailController,
                                validation: validEmail,
                                maxLen: 40),

                            // location
                            locationFeild(
                                hintText: "اضغط لتحديد الموقع",
                                icon: Icons.pin_drop_rounded,
                                inputType: TextInputType.name,
                                maxLines: 3,
                                controller: bioController,
                                context: context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "تسجيل",
                          onPressed: () => storeData(),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Color(0xad2c4339),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(150)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
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

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    String? Function(String?)? validation,
    int? maxLen,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: primaryDarkGrean,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        maxLength: maxLen,
        readOnly: readOnly,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: hintText,
          hintText: hintText,
          suffix: Icon(
            icon,
            color: primaryDarkGrean,
            size: 30,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          labelStyle:
              const TextStyle(color: primaryDarkGrean, fontFamily: "Almarai"),
          fillColor: Colors.white,
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

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      location: bioController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const navBar(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "الرجاء تحميل صورة الملف الشخصي");
    }
  }
}
