import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr/features/chat/firebase_provider.dart';
import 'package:quikhyr/features/chat/notification_service.dart';
import 'package:quikhyr/features/chat/presentation/components/chat_messages.dart';
import 'package:quikhyr/features/chat/presentation/components/chat_text_field.dart';

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

  // Future<void> _respondToBookingProposal(
  //     BuildContext context, bool isAccepted) async {
  //   await FirebaseFirestoreService.respondToBookingProposal(
  //       receiverId: widget.workerId, isAccepted: isAccepted);

  //   await notificationsService.sendNotification(
  //     body: "Booking Accepted By ${FirebaseAuth.instance.currentUser!.uid}",
  //     senderId: FirebaseAuth.instance.currentUser!.uid,
  //   );
  //   if (context.mounted) {
  //     FocusScope.of(context).unfocus();
  //   }

  //   if (context.mounted) {
  //     FocusScope.of(context).unfocus();
  //   }
  // }

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
