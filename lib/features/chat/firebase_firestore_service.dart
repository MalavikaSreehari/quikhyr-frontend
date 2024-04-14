import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr/models/chat_list_model.dart';
import 'package:quikhyr/models/chat_message_model.dart';

import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  // static Future<void> createUser({
  //   required String name,
  //   required String image,
  //   required String email,
  //   required String uid,
  // }) async {
  //   final user = ClientModel(
  //     id: uid,
  //     email: email,
  //     name: name,
  //   );

  //   await firestore
  //       .collection('users')
  //       .doc(uid)
  //       .set(user.toJson());
  // }

  // static Future<void> respondToBookingProposal({
  //   required String receiverId,
  //   required bool isAccepted,
  // }) async {
  //   final message = ChatMessageModel(
  //     content: 'Booking Accepted By ${FirebaseAuth.instance.currentUser!.uid}',
  //     hasResponded: true,
  //     isAccepted: isAccepted,
  //     sentTime: DateTime.now(),
  //     receiverId: receiverId,
  //     messageType: MessageType.booking,
  //     senderId: FirebaseAuth.instance.currentUser!.uid,
  //   );
  //   await _addMessageToChat(receiverId, message);
  // }

  static Future<void> updateBookingProposal({
    required String receiverId,
    required bool isAccepted,
    required String textMessageId,
  }) async {
    await firestore
        .collection('clients')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .update({'isAccepted': isAccepted, 'hasResponded': true});
    await firestore
        .collection('workers')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .update({'isAccepted': isAccepted, 'hasResponded': true});
  }

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = ChatMessageModel(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = ChatMessageModel(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> _addMessageToChat(
    String receiverId,
    ChatMessageModel message,
  ) async {
    var newDocId = firestore.collection('clients').doc().id;
    await firestore
        .collection('clients')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .doc(newDocId)
        .set(message.toJson());

    await firestore
        .collection('workers')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(newDocId)
        .set(message.toJson());
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async =>
      await firestore
          .collection('clients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

  static Future<List<ChatListModel>> searchUser(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('workers')
        .where("name", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => ChatListModel.fromMap(doc.data()))
        .toList();
  }
}
