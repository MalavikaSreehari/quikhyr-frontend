// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ChatMessageModel extends Equatable {
  final String messageId;
  final String senderName;
  final String senderId;
  final String text;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.messageId,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.timestamp,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    //make sure the keys are correct as in the database
    return ChatMessageModel(
      messageId: map['messageId'],
      senderName: map['name'],
      senderId: map['sender'],
      text: map['text'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  @override
  List<Object?> get props => [senderId, text, timestamp, senderName];

  // Add a toMap method if you need to write data back to Firebase
}
