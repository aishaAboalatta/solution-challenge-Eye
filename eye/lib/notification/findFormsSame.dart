import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../imageDetection/ml_service.dart';

final MLService _mlService = MLService();
FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
String userId = user!.uid;

getAllForms() {
  db.collection("loseForm").where("userId", isEqualTo: userId).get().then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

checkSmilirity() {
  //list1
  getAllForms();
  _mlService.compare("list1", "list2");
}
