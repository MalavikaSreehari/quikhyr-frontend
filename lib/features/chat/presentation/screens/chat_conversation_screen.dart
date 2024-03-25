import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr/features/chat/firebase_provider.dart';
import 'package:quikhyr/features/chat/presentation/components/chat_messages.dart';
import 'package:quikhyr/features/chat/presentation/components/chat_text_field.dart';
import 'package:quikhyr/models/client_model.dart';
import 'package:quikhyr/models/worker_model.dart';

class ChatConversationScreen extends StatefulWidget {
  final ClientModel worker;
  const ChatConversationScreen({super.key, required this.worker});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      .getMessages(widget.worker.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            ChatMessages(
              receiverId: widget.worker.id,
            ),
            ChatTextField(
              receiverId: widget.worker.id,
            )
          ]),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.worker.avatar),
          ),
          const SizedBox(width: 10),
          Text(widget.worker.name),
        ],
      ),
    );
  }
}
