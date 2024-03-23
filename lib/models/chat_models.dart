// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// // class ChatUserModel {
// //   final String id;
// //   final String name;
// //   final String photo;
// //   final List<String> chats;

// //   ChatUserModel({required this.id, required this.name, required this.photo, required this.chats});
// // }

// // class ChatModel {
// //   final String id;
// //   final List<String> participants;
// //   final List<String> messages;

// //   ChatModel({required this.id, required this.participants, required this.messages});
// // }

// // class ChatMessageModel {
// //   final String id;
// //   final String sender;
// //   final String text;
// //   final int timestamp;
// //   final String? image;

// //   ChatMessageModel({required this.id, required this.sender, required this.text, required this.timestamp, this.image});
// // }

// class MessageModel {
//   final String sender;
//   final String text;
//   final String timestamp;
//   MessageModel({
//     required this.sender,
//     required this.text,
//     required this.timestamp,
//   });

//   MessageModel copyWith({
//     String? sender,
//     String? text,
//     String? timestamp,
//   }) {
//     return MessageModel(
//       sender: sender ?? this.sender,
//       text: text ?? this.text,
//       timestamp: timestamp ?? this.timestamp,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'sender': sender,
//       'text': text,
//       'timestamp': timestamp,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       sender: map['sender'] as String,
//       text: map['text'] as String,
//       timestamp: map['timestamp'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'MessageModel(sender: $sender, text: $text, timestamp: $timestamp)';

//   @override
//   bool operator ==(covariant MessageModel other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.sender == sender &&
//       other.text == text &&
//       other.timestamp == timestamp;
//   }

//   @override
//   int get hashCode => sender.hashCode ^ text.hashCode ^ timestamp.hashCode;
// }
