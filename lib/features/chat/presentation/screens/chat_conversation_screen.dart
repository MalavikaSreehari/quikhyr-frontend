import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr/features/booking/repository/booking_repository.dart';
import 'package:quikhyr/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr/features/chat/firebase_provider.dart';
import 'package:quikhyr/features/chat/notification_service.dart';
import 'package:quikhyr/features/chat/presentation/components/chat_messages.dart';
import 'package:quikhyr/features/chat/presentation/components/chat_text_field.dart';
import 'package:quikhyr/models/simple_booking_model.dart';
import 'package:quikhyr/models/location_model.dart';

class ChatConversationScreen extends StatefulWidget {
  final String workerId;
  const ChatConversationScreen({super.key, required this.workerId});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final NotificationsService notificationsService = NotificationsService();
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getWorkerById(widget.workerId)
      ..getMessages(widget.workerId);
    notificationsService.getReceiverToken(widget.workerId);
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
              receiverId: widget.workerId,
            ),
            ChatTextField(
              receiverId: widget.workerId,
            )
          ]),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Consumer<FirebaseProvider>(
            builder: (context, value, child) => value.user != null
                ? Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(value.user!.avatar),
                      ),
                      const SizedBox(width: 10),
                      Text(value.user!.name),
                    ],
                  )
                : const SizedBox()));
  }
}
