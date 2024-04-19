import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
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
        appBar: ChatScreenAppBar(),
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
}

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AppBar(
              titleSpacing: 24,
              backgroundColor: Colors.transparent,
              leading: Row(
                children: [
                  QuikSpacing.hS12(),
                  ClickableSvgIcon(
                    svgAsset: QuikAssetConstants.backArrowSvg,
                    size: 32,
                    onTap: () {
                      context.pop();
                    },
                  ),
                  QuikSpacing.hS12(),
                ],
              ),
              automaticallyImplyLeading: false,
              title: Consumer<FirebaseProvider>(
                  builder: (context, value, child) => value.user != null
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 38,
                                  width: 38,
                                  // padding: const EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(value.user!.avatar),
                                  ),
                                ),
                                QuikSpacing.hS12(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.user!.name,
                                      style: workerListNameTextStyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const GradientSeparator(
                              paddingTop: 18,
                              paddingBottom: 0,
                            )
                          ],
                        )
                      : const SizedBox()))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}
