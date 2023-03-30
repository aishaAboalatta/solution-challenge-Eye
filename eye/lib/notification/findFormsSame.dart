import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/model/loseFormModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../imageDetection/ml_service.dart';
import 'notify.dart';

final MLService _mlService = MLService();
FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
String userId = user!.uid;

Future<List<loseFormModel>> getAllForms() async {
  final QuerySnapshot<Map<String, dynamic>> questionsQuery =
      await FirebaseFirestore.instance
          .collection("loseForm")
          .where("userId", isEqualTo: userId)
          .get();
  List<loseFormModel> loseForms = questionsQuery.docs
      .map((loseForm) => loseFormModel.fromSnapshot(loseForm))
      .toList();
  return loseForms;
  //.get().then(
  //  (querySnapshot) {
  //    print("Successfully completed");
  /*for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }*/
  //  },
  //  onError: (e) => print("Error completing: $e"),
  //);
}

checkSmilirity(List? findArray, service, findDocId) async {
  //list1
  List<loseFormModel> loseForms = await getAllForms();
  for (var loseForm in loseForms) {
    List? loseArray = loseForm.predectedArray;
    String result = await _mlService.compare(findArray!, loseArray);
    if (result == "same") {
      createNotification(
          0, "تطابق", "تطابق بلاغ فقدك مع بلاغ عثور", "", service);
      db
          .collection("findForm")
          .doc(findDocId)
          .update({"state": "تم ايجاد تطابق"});
      db
          .collection("loseForm")
          .doc(loseForm.id)
          .update({"state": "تم ايجاد تطابق"});
      break;
    }
  }
}
