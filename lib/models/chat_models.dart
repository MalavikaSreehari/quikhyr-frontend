class ChatUserModel {
  final String id;
  final String name;
  final String photo;
  final List<String> chats;

  ChatUserModel({required this.id, required this.name, required this.photo, required this.chats});
}

class ChatModel {
  final String id;
  final List<String> participants;
  final List<String> messages;

  ChatModel({required this.id, required this.participants, required this.messages});
}

class ChatMessageModel {
  final String id;
  final String sender;
  final String text;
  final int timestamp;
  final String? image;

  ChatMessageModel({required this.id, required this.sender, required this.text, required this.timestamp, this.image});
}