import 'package:animated_widgets/animated_widgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:eye/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eye/register/provider/auth_provider.dart';
import 'package:eye/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool isVisible = false;
  final PageController controller = PageController();

  Country selectedCountry = Country(
    phoneCode: "20",
    countryCode: "EG",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Egypt",
    example: "Egypt",
    displayName: "Egypt",
    displayNameNoCountryCode: "EG",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      backgroundColor: lightYellow,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: !isVisible,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(15),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            //color: Color.fromARGB(200, 211, 107, 0),
                            color: Color.fromRGBO(44, 67, 57, 50),
                          ),
                          child: const Text(
                            "عن التطبيق",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: lightYellow,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                  ),
                  //about app with guide
                  Visibility(
                    visible: isVisible,
                    child: TranslationAnimatedWidget(
                      enabled: true,
                      values: const [
                        Offset(0, -100), // disabled value value
                        Offset(0, 0) //enabled value
                      ],
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(15),
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            //color: Color.fromARGB(200, 211, 107, 0),
                            color: Color.fromRGBO(44, 67, 57, 50),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: lightYellow,
                                      size: 40,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 230,
                                child: PageView(
                                  controller: controller,
                                  children: [
                                    appGuide(
                                        "هذا التطبيق تم تقديمه كمشاركة في تحدي الحلول لإيجاد حل لمساعده الفاقد والمفقود",
                                        "assets/guide1.png"),
                                    appGuide(
                                        "ساعدنا لنكون عيناً للفاقد عن طريق الإبلاغ في حالة عثورك على شخص مفقود",
                                        "assets/guide2.png"),
                                    appGuide(
                                        "بإمكانك ايضا الأبلاغ عن فقدك لشخص وفي حالة العثور على نتائج مطابقة لفقيدك سنعلمك بذلك ",
                                        "assets/guide3.png")
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SmoothPageIndicator(
                                controller: controller, // PageController
                                count: 3,

                                textDirection: TextDirection.rtl,
                                effect: const WormEffect(
                                    dotWidth: 14.0,
                                    dotHeight: 14.0,
                                    /*spacing: 8.0,
                                    radius: 4.0,
                                    dotWidth: 24.0,
                                    dotHeight: 16.0,*/
                                    dotColor: Colors.grey,
                                    activeDotColor: lightYellow),
                              )
                            ],
                          )),
                    ),
                  ),
                  Visibility(
                    visible: !isVisible,
                    child: const SizedBox(
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    width: 250,
                    height: 150,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      //color: Colors.white,
                    ),
                    child: Image.asset(
                      "assets/logo2.png",
                    ),
                  ),

                  const Text(
                    "لتسجيل الدخول أو تسجيل حساب",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "تأكد من رمز الدولة ثم قم بإدخال رقم هاتفك \nوسنقوم بإرسال رمز تحقق لك",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      cursorColor: primaryDarkGrean,
                      controller: phoneController,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "أدخل رقم الهاتف",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        suffix: Container(
                          padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 4),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550,
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  });
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        prefixIcon: phoneController.text.length >= 9
                            ? Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: CustomButton(
                          text: "دخول", onPressed: () => sendPhoneNumber()),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 186,
                            height: 186,
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
                                  topLeft: Radius.circular(186)),
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
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}

Widget appGuide(text, photoPath) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 160,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: lightYellow,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.4),
        ),
      ),
      SizedBox(
        width: 170,
        child: Image.asset(
          photoPath,
          fit: BoxFit.contain,
        ),
      ),
    ],
  );
}
