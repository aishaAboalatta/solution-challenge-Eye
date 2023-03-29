import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../imageDetection/imageDetection.dart';
import '../location/currentLocation.dart';
import '../model/loseFormModel.dart';
import '../widgets/appBar.dart';
import '../widgets/toastMssg.dart';
import '../widgets/utils/utils.dart';

class loseForm extends StatefulWidget {
  const loseForm({super.key});

  @override
  State<loseForm> createState() => _loseFormState();
}

class _loseFormState extends State<loseForm> {
  final _formKey = GlobalKey<FormState>();
  var uploadImageUrl = "";
  File? image;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  TextEditingController nameinput = TextEditingController();
  TextEditingController ageinput = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController descinput = TextEditingController();
  TextEditingController locController = TextEditingController();
  String? shareOptions;

  @override
  void initState() {
    nameinput.text = "";
    ageinput.text = "";
    dateinput.text = "";
    timeinput.text = "";
    descinput.text = "";
    locController.text = "";
    super.initState();
  }

  // for selecting image
  Future selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  // for selecting image
  Future selectImageCam() async {
    image = await pickImageCam(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
            context: context,
            title: 'فقدت شخص',
            icon: Icons.close_rounded,
            dialog: true,
            text: "ستفقد ما قمت بإضافته \n هل أنت متأكد؟",
            photo: "assets/erase.png",
            option: "نعم"),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              image == null ? imageForm() : imageFormAfter(image),
              ////////////
              const SizedBox(height: 10),
              formField(nameinput, "الاسم", Icons.pin, TextInputType.name,
                  validName, 30, 1),
              formField(ageinput, "العمر (بالسنوات)", Icons.calendar_month,
                  TextInputType.datetime, validAge, 2, 1),
              formDateTimeField(dateinput, "التاريخ", Icons.calendar_month,
                  TextInputType.none, validDate, 10, showDate),
              formDateTimeField(timeinput, "الوقت", Icons.timer,
                  TextInputType.none, validTime, 7, showTime),

              /// الموقع
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: locationFeild(
                    hintText: "اضغط لتحديد الموقع",
                    icon: Icons.pin_drop_rounded,
                    inputType: TextInputType.name,
                    maxLines: 2,
                    controller: locController,
                    context: context,
                    maxLen: 150),
              ),
              // وصف
              formField(descinput, "وصف تفصيلي", Icons.pin,
                  TextInputType.multiline, validDescri, 200, 3),
              //share options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "خيارات نشر البلاغ",
                      style: TextStyle(fontSize: 18, color: primaryDarkGrean),
                    ),
                    RadioListTile(
                      title: const Text("عدم النشر"),
                      value: "noOne",
                      groupValue: shareOptions,
                      activeColor: primaryDarkGrean,
                      onChanged: (value) {
                        setState(() {
                          shareOptions = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("نشر للأصدقاء فقط"),
                      value: "onlyFriends",
                      groupValue: shareOptions,
                      activeColor: primaryDarkGrean,
                      onChanged: (value) {
                        setState(() {
                          shareOptions = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("نشر لجميع مستخدمي التطبيق"),
                      value: "All",
                      groupValue: shareOptions,
                      activeColor: primaryDarkGrean,
                      onChanged: (value) {
                        setState(() {
                          shareOptions = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              submitBttn(),
            ],
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

  String? validAge(value) {
    if (value!.trim() == null || value.trim().isEmpty) {
      return 'أدخل العمر';
    }
    if (int.parse(value) < 1) {
      return "أدخل عمر أكبر من الصفر";
    }

    return null;
  }

  String? validDate(value) {
    if (value!.trim() == null || value.trim().isEmpty) {
      return 'اختر التاريخ';
    }

    return null;
  }

  String? validTime(value) {
    if (value!.trim() == null || value.trim().isEmpty) {
      return 'اختر الوقت';
    }

    return null;
  }

  String? validDescri(value) {
    return null;
  }

  Widget imageForm() {
    return Center(
      child: Stack(children: <Widget>[
        GestureDetector(
          onTap: () {
            showPhotoDialog();
          },
          child: Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryDarkGrean,
              boxShadow: [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
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
          ),
        ),
      ]),
    );
  }

  Widget imageFormAfter(image) {
    return Center(
      child: Stack(children: <Widget>[
        GestureDetector(
          onTap: () {
            showPhotoDialog();
          },
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(image!)),
              shape: BoxShape.circle,
              color: primaryDarkGrean,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 35,
                ),
                Text(
                  "تغيير الصورة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
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
                  await selectImage();
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  String userId = user!.uid;

                  String nowTime =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  await storeFileToStorage(
                          "loseFormPic/${userId}-${nowTime}", image!)
                      .then((value) {
                    uploadImageUrl = value;
                  });
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
                  await selectImageCam();
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  String userId = user!.uid;

                  String nowTime =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  await storeFileToStorage(
                          "loseFormPic/${userId}-${nowTime}", image!)
                      .then((value) {
                    uploadImageUrl = value;
                  });
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

  Widget formDateTimeField(
    TextEditingController controll,
    String title,
    IconData icon,
    TextInputType input,
    String? Function(String?)? validation,
    int maxLen,
    Function()? show,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: controll,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: input,
        maxLength: maxLen,
        readOnly: true, //set it true, so that user will not able to edit text

        onTap: show,

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

  void showDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryDarkGrean,
              onPrimary: Colors.white,
              onSurface: Colors.blueAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryDarkGrean,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateinput.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  void showTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryDarkGrean,
              onPrimary: Colors.white,
              onSurface: Colors.blueAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryDarkGrean,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        timeinput.text = pickedTime.format(context);
      });
    } else {
      print("Time is not selected");
    }
  }

  Widget submitBttn() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            /*
            List? array = [
              -0.01702696830034256,
              0.03669794276356697,
              0.017164362594485283,
              0.0032593877986073494,
              -0.06348714977502823,
              0.09823022782802582,
              -0.08304639905691147,
              -0.11829375475645065,
              -0.10516717284917831,
              -0.04794669896364212,
              -0.02049948461353779,
              0.012281193397939205,
              -0.008516287431120872,
              0.03501773253083229,
              -0.003100056666880846,
              -0.01973763294517994,
              -0.02905753254890442,
              -0.007473887875676155,
              0.0019424263155087829,
              0.003717653453350067,
              -0.19119137525558472,
              0.0867079347372055,
              -0.045135438442230225,
              0.014498111791908741,
              -0.016003288328647614,
              0.016655461862683296,
              -0.05340960621833801,
              0.06565283983945847,
              0.19477668404579163,
              -0.12294705957174301,
              -0.009153815917670727,
              0.2526645362377167,
              0.07628714293241501,
              -0.0022129379212856293,
              -0.14698179066181183,
              0.17843914031982422,
              -0.03250308334827423,
              -0.015198597684502602,
              0.0011564827291294932,
              -0.08369722962379456,
              0.010453961789608002,
              0.00499044731259346,
              0.017474595457315445,
              -0.010559789836406708,
              0.007143479306250811,
              -0.071443997
            ];
            // List? array = await getPredectedArray(image!.path);
*/

            createNewInform(); //array

            Future.delayed(const Duration(seconds: 1), () {
              showToast("تم رفع البلاغ بنجاح");
              Navigator.pop(context);
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryDarkGrean),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        ),
        child: const Text(
          "إبلاغ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: "Almarai",
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future createNewInform() async {
    //List? array
    //array
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String userId = user!.uid;
    print("==========start");
    final newForm = FirebaseFirestore.instance.collection('loseForm').doc();
    loseFormModel form = loseFormModel(
      id: newForm.id,
      userId: userId,
      name: nameinput.text,
      photo: uploadImageUrl,
      age: num.parse(ageinput.text),
      date: dateinput.text,
      time: timeinput.text,
      location: locController.text,
      description: descinput.text,
      state: "لم يتم العثور بعد",
      //predectedArray: array!
    );
    print("==========middle");
    final json = form.toJson();
    await newForm.set(json);

    print("==========end form creation");
  }
}
