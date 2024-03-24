import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr/models/chat_message_model.dart';
import 'package:quikhyr/models/worker_model.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<WorkerModel> users = [];
  WorkerModel? user;
  List<ChatMessageModel> messages = [];
  List<WorkerModel> search = [];

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

  WorkerModel? getWorkerById(String userId) {
    FirebaseFirestore.instance
        .collection('workers')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = WorkerModel.fromMap(user.data()!);
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

  void scrollDown() =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
              scrollController.position.maxScrollExtent);
        }
      });

  Future<void> searchUser(String name) async {
    search =
        await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }
}
