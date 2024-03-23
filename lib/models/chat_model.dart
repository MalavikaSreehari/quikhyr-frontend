// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:quikhyr/models/chat_message_model.dart';

class ChatModel extends Equatable {
  final String id;
  final Map<String, ChatMessageModel> messages;
  final Map<String, bool> participants;

  const ChatModel({
    required this.id,
    required this.messages,
    required this.participants,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatModel(
      id: id,
      messages: (map['messages'] as Map).map(
        (key, value) => MapEntry(
            key, ChatMessageModel.fromMap(Map<String, dynamic>.from(value))),
      ),
      participants: Map<String, bool>.from(map['participants']),
    );
  }

  @override
  List<Object?> get props => [id, messages, participants];

  // Add a toMap method if you need to write data back to Firebase
}
