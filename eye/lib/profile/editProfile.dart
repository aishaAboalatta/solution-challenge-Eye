import 'package:eye/widgets/appBar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class editProfile extends StatefulWidget {
  var ImageUrl, name, phone, email;
  editProfile(
      {super.key,
      required this.ImageUrl,
      required this.name,
      required this.phone,
      required this.email});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameinput = TextEditingController();
  TextEditingController phoneinput = TextEditingController();
  TextEditingController emailinput = TextEditingController();

  @override
  void initState() {
    nameinput.text = widget.name;
    phoneinput.text = widget.phone;
    emailinput.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
            title: "تعديل الملف الشخصي",
            context: context,
            icon: Icons.close_rounded),
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
                      Container(
                        margin: const EdgeInsets.only(bottom: 7, top: 43),
                        width: 141,
                        height: 141,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.ImageUrl, fit: BoxFit.cover),
                          color: white,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                    validName, 40, 1),
                //رقم الهاتف
                formField(phoneinput, "رقم الهاتف", Icons.phone,
                    TextInputType.datetime, validName, 13, 1),
                //الايميل
                formField(emailinput, "البريد الإلكتروني", Icons.email,
                    TextInputType.emailAddress, validEmail, 40, 1),
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
                  /*
                  // Pick an image
                  final XFile? photo =
                      await _picker.pickImage(source: ImageSource.gallery);
                  try {
                    final file = File(photo!.path);
                    uploadImageToFirebaseStorage(file);
                  } catch (e) {
                    print("error");
                  }
                  Navigator.of(context).pop();
                  */
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
                  /*
                  // Capture a photo
                  final XFile? photo =
                      await _picker.pickImage(source: ImageSource.camera);

                  final file = File(photo!.path);
                  uploadImageToFirebaseStorage(file);
                  Navigator.of(context).pop();
                  */
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
      int maxLine) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
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

  Widget submitBttn() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {}
          /*final isValid = _formKey.currentState.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              _formKey.currentState.save();

              final message =
                  'Username: $username\nPassword: $password\nEmail: $email';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }*/
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryDarkGrean),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
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
}
