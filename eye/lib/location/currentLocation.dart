import 'package:flutter/material.dart';
import '../constants/colors.dart';

import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

Widget locationFeild({
  required String hintText,
  required IconData icon,
  required TextInputType inputType,
  required int maxLines,
  required TextEditingController controller,
  required BuildContext context,
  String? Function(String?)? validation,
  int? maxLen,
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
      readOnly: true,
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacePicker(
              apiKey: apiKey,

              initialPosition: const LatLng(31.110022, 30.947355),
              useCurrentLocation: true,
              resizeToAvoidBottomInset:
                  false, // only works in page mode, less flickery, remove if wrong offsets
              selectedPlaceWidgetBuilder:
                  (_, selectedPlace, state, isSearchBarFocused) {
                return isSearchBarFocused
                    ? Container()
                    // Use FloatingCard or just create your own Widget.
                    : FloatingCard(
                        bottomPosition:
                            MediaQuery.of(context).size.height * 0.1,
                        leftPosition: MediaQuery.of(context).size.width * 0.15,
                        rightPosition: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.7,
                        borderRadius: BorderRadius.circular(12.0),
                        elevation: 4.0,
                        color: Theme.of(context).cardColor,
                        child: state == SearchingState.Searching
                            ? const Center(child: CircularProgressIndicator())
                            : _buildDetails(
                                _, context, selectedPlace!, controller));
              },
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildDetails(BuildContext context, BuildContext contextPage,
    PickResult result, controller) {
  MaterialStateColor buttonColor =
      MaterialStateColor.resolveWith((states) => Colors.lightGreen);

  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        Text(
          result.formattedAddress!,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.width * 0.8,
              56), // button width and height
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Material(
              child: InkWell(
                  overlayColor: buttonColor,
                  onTap: () {
                    controller.text = result.formattedAddress;

                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, color: buttonColor),
                      SizedBox.fromSize(size: const Size(10, 0)),
                      Text("اضغط هنا لحفظ موقعك",
                          style: TextStyle(color: buttonColor)),
                    ],
                  )),
            ),
          ),
        )
      ],
    ),
  );
}
