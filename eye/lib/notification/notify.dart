import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye/notification/findFormsSame.dart';
import './LocalNotificationService.dart';

void listenToDB(LocalNotificationService service) {
  print("the notification form firestore method was called");

  CollectionReference reference =
      FirebaseFirestore.instance.collection('findForm');

  reference.snapshots().listen((querySnapshot) {
    for (var change in querySnapshot.docChanges) {
      if (change.type == DocumentChangeType.added) {
        for (var index = 0; index < querySnapshot.size; index++) {
          //documend that added on find
          var data = querySnapshot.docs.elementAt(index).data() as Map;

          var findDocId = data["id"];
          var findArray = data["predectedArray"];

          checkSmilirity(findArray, service, findDocId); //findArray
        }
      }
    }
  });
}

//Create notification=================================================
void createNotification(int id, String title, String body, String payload,
    LocalNotificationService service) async {
  await service.showNotificationWithPayload(
      id: id,
      title: title,
      body: body,
      //what should be the payload?
      payload: 'payload content');
}

//Navigator push when cklicking on the notification(should open product list page)
void listenToNotification(LocalNotificationService service) =>
    service.onNotificationClick.stream.listen(onNoticationListener);

void onNoticationListener(String? payload) {
  if (payload != null && payload.isNotEmpty) {
    print('payload: $payload');
    /*   Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => )));*/
  }
}
