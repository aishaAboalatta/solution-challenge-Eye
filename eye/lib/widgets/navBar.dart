import 'package:eye/tracking/track.dart';
import 'package:eye/widgets/appBar.dart';
import 'package:eye/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../constants/colors.dart';
import '../lose&find/findForm.dart';
import '../lose&find/loseForm.dart';
import '../myForms/myForms.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(context),
        backgroundColor: primaryDarkGrean,
        navBarHeight: 58,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0),
        ),

/* see if you need any or delete
        //
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        //
*/
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const home(),
      const track(),
      const home(),
      const myForms(),
      const home()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    TextStyle navTextStyle = const TextStyle(
      fontFamily: "Almarai",
      fontSize: 11,
      fontWeight: FontWeight.w700,
    );
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("الرئيسية"),
        textStyle: navTextStyle,
        activeColorPrimary: white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.placemark),
        title: ("تتبعني"),
        textStyle: navTextStyle,
        activeColorPrimary: white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        iconSize: 32,
        icon: const Icon(
          CupertinoIcons.add,
          color: white,
        ),
        title: ("أبلغ"),
        textStyle: navTextStyle,
        activeColorPrimary: darkOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        onPressed: (p0) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return reportOptions(context);
              });
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: ("بلاغاتي"),
        textStyle: navTextStyle,
        activeColorPrimary: white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.question_circle),
        title: ("أرشدني"),
        textStyle: navTextStyle,
        activeColorPrimary: white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

Widget reportOptions(context) {
  //المربع الكبير
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        height: 450,
        decoration: const BoxDecoration(
          /*
           border: Border.all(
            color: primaryDarkGrean,
            width: 1.5,
          ),*/
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(21), topRight: Radius.circular(21)),
          boxShadow: [
            BoxShadow(
              //color: Color(0x3f000000),
              color: primaryDarkGrean,
              blurRadius: 3,
              offset: Offset(-2, -4),
            ),
          ],
          color: Colors.white,
        ),
        // المحتوى
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان وزر الاغلاق
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DefaultTextStyle(
                  style: TextStyle(
                    color: darkOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Almarai",
                  ),
                  child: Text(
                    "أبلغ",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: darkOrange,
                    size: 30,
                  ),
                ),
              ],
            ),
            //العنوان الفرعي
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: SizedBox(
                height: 25,
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: primaryDarkGrean,
                      fontSize: 13,
                      fontFamily: "Almarai",
                      fontWeight: FontWeight.w700,
                      height: 1.5),
                  child: Text(
                    "بإمكانك الإبلاغ عن فقدان أو إيجاد شخص",
                  ),
                ),
              ),
            ),
            const Divider(
              height: 10,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: primaryDarkGrean,
            ),
            // الاختيار الاول
            GestureDetector(
              onTap: () {
                //put the page that will route to
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: loseForm(), //page name here
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                height: 130,
                width: 333,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: primaryDarkGrean,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontFamily: "Almarai",
                              height: 1.5),
                          child: Text(
                            "فقدت شخص ",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 250,
                          child: DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: "Almarai",
                                height: 1.5),
                            child: Text(
                              "اختر هذا الخيار ان فقدت شخص وتريد الأبلاغ عن اختفائة من مدة قليلة او حتى من سنوات",
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // الاختيار الثاني
            GestureDetector(
              onTap: () {
                //put the page that will route to
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: findForm(),
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(10),
                height: 130,
                width: 333,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: primaryDarkGrean,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontFamily: "Almarai",
                              height: 1.5),
                          child: Text(
                            "عثرت على شخص",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 250,
                          child: DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: "Almarai",
                                height: 1.5),
                            child: Text(
                              "اختر هذا الخيار ان وجدت أي شخص ضائع أو ان كنت مفقوداً تبحث عن عائلتك",
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}
