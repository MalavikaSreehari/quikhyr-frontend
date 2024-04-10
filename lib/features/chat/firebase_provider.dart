import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr/models/chat_message_model.dart';
import 'package:quikhyr/models/client_model.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<ClientModel> users = [];
  ClientModel? user;
  List<ChatMessageModel> messages = [];
  List<ClientModel> search = [];

  Future<List<ClientModel>> getAllWorkers() async {
    var workersCollection = FirebaseFirestore.instance.collection('workers');
    // var clientsCollection = FirebaseFirestore.instance.collection('clients');

    var workersSnapshot = await workersCollection.get();
    // var clientsSnapshot = await clientsCollection.get();

    var workers = workersSnapshot.docs
        .map((doc) => ClientModel.fromMap(doc.data()))
        .toList();

    // var clients = clientsSnapshot.docs
    //     .map((doc) => ClientModel.fromMap(doc.data()))
    //     .toList();

    // users = [...workers, ...clients];

    users = workers;
    notifyListeners();

    return users;
  }

  ClientModel? getWorkerById(String userId) {
    FirebaseFirestore.instance
        .collection('workers')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = ClientModel.fromMap(user.data()!);
      notifyListeners();
    });
    return user;
  }

  List<ChatMessageModel> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('clients')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages = messages.docs
          .map((doc) => ChatMessageModel.fromJson(doc.data()))
          .toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  // Future<void> searchUser(String name) async {
  //   search =
  //       await FirebaseFirestoreService.searchUser(name);
  //   notifyListeners();
  // }
}
