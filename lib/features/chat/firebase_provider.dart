import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_firestore_service.dart';
import '../../models/chat_list_model.dart';
import '../../models/chat_message_model.dart';
import '../../models/client_model.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<ChatListModel> users = [];
  ClientModel? user;
  List<ChatMessageModel> messages = [];
  List<ChatListModel> search = [];
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Stream<List<ChatListModel>> getAllWorkersWithLastMessageStream() {
    var streamController = StreamController<List<ChatListModel>>.broadcast();

    FirebaseFirestore.instance
        .collection('workers')
        .snapshots()
        .listen((workerSnapshot) {
      List<ChatListModel> initialUsers = [];
      for (var doc in workerSnapshot.docs) {
        var workerData = doc.data() as Map<String, dynamic>?;
        if (workerData != null) {
          // Fetch the last message for this worker
          FirebaseFirestore.instance
              .collection('clients')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('chat')
              .doc(doc.id)
              .collection('messages')
              .orderBy('sentTime', descending: true)
              .limit(1)
              .get()
              .then((messageSnapshot) {
            if (messageSnapshot.docs.isNotEmpty) {
              var messageData =
                  messageSnapshot.docs.first.data() as Map<String, dynamic>;
              String lastMessage = messageData['content'] ?? '';
              DateTime sentTime =
                  (messageData['sentTime'] as Timestamp).toDate();
              MessageType messageType =
                  stringToMessageType(messageData['messageType']);

              ChatListModel workerWithLastMessage = ChatListModel(
                name: workerData['name'],
                id: doc.id,
                isVerified: workerData['isVerified'] ?? false,
                isActive: workerData['isActive'] ?? false,
                avatar: workerData['avatar'] ?? '',
                lastMessage: lastMessage,
                sentTime: sentTime,
                messageType: messageType,
              );

              initialUsers.add(workerWithLastMessage);
            }
            // Emit the initial list of users with the last message
            streamController.add(initialUsers);
          });
        }
      }
    });

    return streamController.stream;
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
          .map((doc) => ChatMessageModel.fromJson(doc.data(), doc.id))
          .toList();
      notifyListeners();
      //!? NOT SURE ABOUT ORDER
      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
              // duration: const Duration(milliseconds: 2000),
              // curve: Curves.easeOut,
              scrollController.position.maxScrollExtent);
        }
      });


  Future<void> searchUser(String name) async {
    search = await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }
}
