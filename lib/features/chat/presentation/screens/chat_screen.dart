import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../common/constants/quik_asset_constants.dart';
import '../../../../common/constants/quik_routes.dart';
import '../../../../common/constants/quik_spacings.dart';
import '../../../../common/constants/quik_themes.dart';
import '../../../../common/widgets/gradient_separator.dart';
import '../../../../common/widgets/quik_app_bar.dart';
import '../../../../common/widgets/quik_search_bar.dart';
import '../../firebase_provider.dart';
import '../../notification_service.dart';
import '../../../../models/chat_list_model.dart';
import '../../../../models/chat_message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final notificationService = NotificationsService();
  TextEditingController searchController = TextEditingController();
  List<ChatListModel> filteredWorkers = [];
  List<ChatListModel> allWorkers = [];

  Timer? searchDebounce;

  void filterClients(String query) {
    if (searchDebounce?.isActive ?? false) {
      searchDebounce?.cancel();
    }
    searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        setState(() {
          filteredWorkers = allWorkers;
        });
      } else {
        setState(() {
          filteredWorkers = allWorkers.where((client) {
            return client.name.toLowerCase().contains(query.toLowerCase());
          }).toList();
        });
      }
    });
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return DateFormat.jm().format(date); // Only hours and AM/PM
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date); // Only date
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    notificationService.firebaseNotification(context);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       FirebaseFirestoreService.updateUserData({
  //         'isActive': true,
  //       });
  //       break;
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.paused:
  //     case AppLifecycleState.detached:
  //       FirebaseFirestoreService.updateUserData({
  //         'isActive': false,
  //       });
  //       break;
  //     default:
  //   }
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuikAppBar(
        pageName: 'Chat',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
        child: Column(
          children: [
            QuikSearchBar(
              onChanged: (String value) {
                filterClients(value);
              }, // Default onChanged function
              hintText: 'Search for clients..', // Default hintText value
              onMicPressed: () {}, // Default onMicPressed function
              onSearch: (String onSearch) {}, // Default onSearch function
              controller: searchController, // Default controller
            ),
            QuikSpacing.vS24(),
            Expanded(
              child: StreamBuilder<List<ChatListModel>>(
                stream: Provider.of<FirebaseProvider>(context)
                    .getAllWorkersWithLastMessageStream(),
                builder: (context, snapshot) {
                  List<ChatListModel> workersToShow =
                      filteredWorkers.isEmpty && searchController.text.isEmpty
                          ? allWorkers
                          : filteredWorkers;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Chats Yet'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  } else if (!snapshot.hasData) {
                    return const Text('No Chats Yet');
                  } else {
                    allWorkers = snapshot.data!;
                    allWorkers.sort((a, b) => b.sentTime.compareTo(a.sentTime));
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const GradientSeparator(),
                      itemBuilder: (context, index) {
                        return workersToShow[index].id !=
                                FirebaseAuth.instance.currentUser?.uid
                            ? ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  alignment: Alignment.center,
                                  height: 64,
                                  width: 64,
                                  child: Stack(
                                    children: [
                                      const Positioned.fill(
                                          child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          QuikAssetConstants.placeholderImage,
                                        ),
                                      )),
                                      // if (state.workers[index].isVerified)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: SvgPicture.asset(
                                          QuikAssetConstants.verifiedBlueSvg,
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: 4,
                                          child: SvgPicture.asset(
                                              workersToShow[index].isActive
                                                  ? QuikAssetConstants
                                                      .chatGreenBubbleSvg
                                                  : QuikAssetConstants
                                                      .chatGreyBubbleSvg)),
                                    ],
                                  ),
                                ),
                                title: Text(workersToShow[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                subtitle: workersToShow[index].messageType ==
                                        MessageType.text
                                    ? Text(
                                        workersToShow[index].lastMessage,
                                        overflow: TextOverflow.ellipsis,
                                        style: chatSubTitle,
                                      )
                                    : const Text(
                                        "Image received",
                                        style: chatSubTitle,
                                      ),
                                trailing: Text(
                                  formatDate(workersToShow[index].sentTime)
                                      .toString(),
                                  style: chatTrailingActive,
                                ),
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      QuikRoutes.chatConversationName,
                                      pathParameters: {
                                        'workerId': workersToShow[index].id
                                      });
                                },
                              )
                            : const SizedBox();
                      },
                      itemCount: workersToShow.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
