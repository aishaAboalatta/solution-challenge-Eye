import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart';
import 'ml_service.dart';

import 'dart:io';
import 'dart:isolate';

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
