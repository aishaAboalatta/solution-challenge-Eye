import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
String userId = user!.uid;

getAllForms() {
  db.collection("loseForm").where("userId", isEqualTo: userId).get().then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        checkSmilirity(docSnapshot.id,docSnapshot.data())
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}


checkSmilirity(){}
