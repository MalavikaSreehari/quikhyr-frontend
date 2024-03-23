import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/models/worker_model.dart';

class FirebaseProvider extends ChangeNotifier {
  List<WorkerModel> users = [];
  List<WorkerModel> getAllWorkers() {
    FirebaseFirestore.instance
        .collection('workers')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users = users.docs
          .map((doc) => WorkerModel.fromMap(doc.data()))
          .toList();
      notifyListeners();
    });
    return users;
  }
}
