// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
class ChatMessageModel extends Equatable{
  final String sender;
  final String text;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      sender: map['sender'],
      text: map['text'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
  
  @override
  List<Object?> get props => [sender, text, timestamp];

  // Add a toMap method if you need to write data back to Firebase
}
