import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart';
import 'ml_service.dart';

import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

final MLService _mlService = MLService();

Future<List?> getPredectedArray(String path) async {
  var receivePort = ReceivePort();

  File imgFile = File(path);

//detect face for lose form
  final inputImage = InputImage.fromFile(imgFile);
  final options =
      FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
  final faceDetector = FaceDetector(options: options);
  final List<Face> faces = await faceDetector.processImage(inputImage);

//convert to Image for lose form
  await Isolate.spawn(
      decodeIsolate, DecodeParam(imgFile, receivePort.sendPort));
  var imageConverted = await receivePort.first as Image;

//array for lose form
  List? losePredectedArray = await _mlService.predict(imageConverted, faces[0]);

  return losePredectedArray;
}

checkSimilirity(losePredectedArray, findPredectedArray) async {
//compare find and lose forms
  await _mlService.compare(findPredectedArray, losePredectedArray);
}

////////----------------------------------------------to be deleted
meth(filePath, filePath1) async {
  var receivePort = ReceivePort();

  print("==========1");
  File? f = await getImageFileFromAssets(filePath);

  final inputImage = InputImage.fromFile(f);
  final options =
      FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
  final faceDetector = FaceDetector(options: options);

  final List<Face> faces = await faceDetector.processImage(inputImage);
  print("==========2--${faces.length}");

  print("==========3");

  await Isolate.spawn(decodeIsolate, DecodeParam(f, receivePort.sendPort));

  var image0 = await receivePort.first as Image;

/*
  //if (faces1.length > 1) {
  //print one face;
  //} else {
  //faces[0];*/
  print("==========4");
  //List? a1 = await _mlService.predict(image1, faces1[0]);

  List? a2 = await _mlService.predict(image0, faces[0]);

  print("==========5");

  meth2(a2, filePath1);

//  for (Face face in faces) {}
}

meth2(a2, filePath) async {
  var receivePort = ReceivePort();

  print("==========1");
  File f = await getImageFileFromAssets(filePath);

  final inputImage = InputImage.fromFile(f);
  final options =
      FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
  final faceDetector = FaceDetector(options: options);

  final List<Face> faces = await faceDetector.processImage(inputImage);
  print("==========2--${faces.length}");

  print("==========3");

  await Isolate.spawn(decodeIsolate, DecodeParam(f, receivePort.sendPort));

  var image0 = await receivePort.first as Image;

/*
  //if (faces1.length > 1) {
  //print one face;
  //} else {
  //faces[0];*/
  print("==========4");
  //List? a1 = await _mlService.predict(image1, faces1[0]);

  List? a1 = await _mlService.predict(image0, faces[0]);

  print("==========5");

  await _mlService.compare(a1, a2);
  // }

//  for (Face face in faces) {}
}

////////////////////////////////----------------until here

class DecodeParam {
  final File file;
  final SendPort sendPort;
  DecodeParam(this.file, this.sendPort);
}

void decodeIsolate(DecodeParam param) {
  // Read an image from file (webp in this case).
  // decodeImage will identify the format of the image and use the appropriate
  // decoder.
  var image = decodeImage(param.file.readAsBytesSync())!;
  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  var thumbnail = copyResize(image, width: 120);
  param.sendPort.send(thumbnail);
}

////////////////////////////////////-----------to be deleted

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
