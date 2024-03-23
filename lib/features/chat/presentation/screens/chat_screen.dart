import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_routes.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/constants/app_theme.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quikhyr/features/chat/blocs/bloc/chat_list_bloc.dart';
import 'package:quikhyr/models/chat_message_model.dart';
import 'package:quikhyr/models/chat_model.dart';

class Message {
  final String sender;
  final String message;

  Message(this.sender, this.message);
}

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final databaseReference = FirebaseDatabase.instance.ref();
  // void pushData() {
  //   final databaseReference = FirebaseDatabase.instance.ref();

  //   databaseReference.child("chats").set({
  //     'chat1': {
  //       'participants': {'user1': true, 'user2': true},
  //       'messages': {
  //         'message1': {
  //           'sender': 'user1',
  //           'text': 'Will meet you tomorrow.',
  //           'timestamp': DateTime.now().toIso8601String()
  //         }
  //       }
  //     },
  //     'chat2': {
  //       'participants': {'user2': true, 'user3': true},
  //       'messages': {
  //         'message1': {
  //           'sender': 'user2',
  //           'text': 'Payment has been transferred.',
  //           'timestamp': DateTime.now().toIso8601String()
  //         }
  //       }
  //     },
  //     'chat3': {
  //       'participants': {'user1': true, 'user3': true},
  //       'messages': {
  //         'message1': {
  //           'sender': 'user1',
  //           'text': 'Thank you for choosing me.',
  //           'timestamp': DateTime.now().toIso8601String()
  //         }
  //       }
  //     }
  //   });

  //   databaseReference.child("users").set({
  //     'user1': {
  //       'name': 'Kenny Kirk',
  //       'avatar': 'assets/images/ratedWorker2.png',
  //       'isVerified': true
  //     },
  //     'user2': {
  //       'name': 'Henry Kal',
  //       'avatar': 'assets/images/ratedWorker3.png',
  //       'isVerified': true
  //     },
  //     'user3': {
  //       'name': 'John Burke',
  //       'avatar': 'assets/images/ratedWorker1.png',
  //       'isVerified': true
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Q',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                        ),
                        TextSpan(
                          text: 'uik',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                        ),
                        TextSpan(
                          text: 'Chat',
                          style: TextStyle(
                              fontFamily: 'Trap',
                              fontSize: 24,
                              letterSpacing: -1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ClickableSvgIcon(
                    svgAsset: AppAssetLinks.bellNotificationActiveSvg,
                    onTap: () {}),
                AppSizing.hS10(),
                ClickableSvgIcon(
                    svgAsset: AppAssetLinks.logoutSvg,
                    onTap: () {
                      // context.read<SignInBloc>().add(const SignOutRequired());
                    }),
                AppSizing.hS24(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
          child: Column(children: [
            QuikSearchBar(
              onChanged: (String value) {}, // Default onChanged function
              hintText: 'Search for chats..', // Default hintText value
              onMicPressed: () {}, // Default onMicPressed function
              onSearch: (String onSearch) {}, // Default onSearch function
              controller: TextEditingController(), // Default controller
            ),
            AppSizing.vS24(),
            Expanded(child: BlocBuilder<ChatListBloc, ChatListState>(
              builder: (context, state) {
                if (state is ChatListLoading) {
                  return const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                } else if (state is ChatListLoaded) {
                  return ListView.builder(
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) {
                      ChatModel chat = state.chats[index];
                      //String chatId = chat.id;
                      Map<String, ChatMessageModel> messages = chat.messages;
                      // Map<String, bool> participants = chat.participants;

                      // Access a specific message
                      ChatMessageModel? message = messages['message1'];
                      // String profilePictureUrl = message?.profilePictureUrl ?? '';
                      String senderName = message?.senderName ?? '';

                      String lastMessage = message?.text ?? '';
                      DateTime timestamp = message?.timestamp ?? DateTime.now();
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: gridItemBackgroundColor,
                              ),
                              alignment: Alignment.center,
                              height: 64,
                              width: 64,
                              child: Stack(
                                children: [
                                  const Positioned.fill(
                                      child: CircleAvatar(
                                    // foregroundColor: textInputBackgroundColor,
                                    backgroundColor: textInputBackgroundColor,
                                    child: Icon(Icons.person),
                                    // backgroundImage: AssetImage(
                                    //   state.chats[index].
                                    // ),
                                  )),
                                  // if (state.workers[index].isVerified)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: SvgPicture.asset(
                                      AppAssetLinks.verifiedBlueSvg,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 4,
                                      child: SvgPicture.asset(
                                          AppAssetLinks.chatGreenBubbleSvg)),
                                ],
                              ),
                            ),
                            title: Text(senderName,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            subtitle: Text(lastMessage, style: chatSubTitle),
                            trailing: Text(
                              timestamp.toString().substring(0, 10),
                              style: chatTrailingActive,
                            ),
                            onTap: () => context.pushNamed(
                                Routes.chatConversationNamedPageName),
                          ),
                          const GradientSeparator(),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: Text(state.toString()));
                }
              },
            ))
            // Expanded(
            //   child: ListView(
            //     shrinkWrap: true,
            //     children: [
            //       ListTile(
            //         contentPadding: EdgeInsets.zero,
            //         leading: Container(
            //           decoration: const BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: gridItemBackgroundColor,
            //           ),
            //           alignment: Alignment.center,
            //           height: 64,
            //           width: 64,
            //           child: Stack(
            //             children: [
            //               const Positioned.fill(
            //                   child: CircleAvatar(
            //                 backgroundImage: AssetImage(
            //                   "assets/images/ratedWorker2.png",
            //                 ),
            //               )),
            //               // if (state.workers[index].isVerified)
            //               Positioned(
            //                 top: 0,
            //                 right: 0,
            //                 child: SvgPicture.asset(
            //                   AppAssetLinks.verifiedBlueSvg,
            //                 ),
            //               ),
            //               Positioned(
            //                   bottom: 0,
            //                   left: 4,
            //                   child: SvgPicture.asset(
            //                       AppAssetLinks.chatGreenBubbleSvg)),
            //             ],
            //           ),
            //         ),
            //         title: Text("Kenny Kirk",
            //             style: Theme.of(context).textTheme.headlineSmall),
            //         subtitle: const Text("Will meet you tomorrow.",
            //             style: chatSubTitle),
            //         trailing: const Text(
            //           "7:04 pm",
            //           style: chatTrailingActive,
            //         ),
            //         onTap: () =>
            //             context.pushNamed(Routes.chatConversationNamedPageName),
            //       ),
            //       const GradientSeparator(),
            //       ListTile(
            //         contentPadding: EdgeInsets.zero,
            //         leading: Container(
            //           decoration: const BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: gridItemBackgroundColor,
            //           ),
            //           alignment: Alignment.center,
            //           height: 64,
            //           width: 64,
            //           child: Stack(
            //             children: [
            //               const Positioned.fill(
            //                   child: CircleAvatar(
            //                 backgroundImage: AssetImage(
            //                   "assets/images/ratedWorker3.png",
            //                 ),
            //               )),
            //               // if (state.workers[index].isVerified)
            //               Positioned(
            //                 top: 0,
            //                 right: 0,
            //                 child: SvgPicture.asset(
            //                   AppAssetLinks.verifiedBlueSvg,
            //                 ),
            //               ),
            //               Positioned(
            //                   bottom: 0,
            //                   left: 4,
            //                   child: SvgPicture.asset(
            //                       AppAssetLinks.chatGreyBubbleSvg)),
            //             ],
            //           ),
            //         ),
            //         title: Text("Henry Kal",
            //             style: Theme.of(context).textTheme.headlineSmall),
            //         subtitle: const Text("Payment has been transferred.",
            //             overflow: TextOverflow.ellipsis,
            //             style: chatSubTitleRead),
            //         trailing: const Text(
            //           "Yesterday",
            //           style: chatTrailingInactive,
            //         ),
            //       ),
            //       const GradientSeparator(),
            //       ListTile(
            //         contentPadding: EdgeInsets.zero,
            //         leading: Container(
            //           decoration: const BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: gridItemBackgroundColor,
            //           ),
            //           alignment: Alignment.center,
            //           height: 64,
            //           width: 64,
            //           child: Stack(
            //             children: [
            //               const Positioned.fill(
            //                   child: CircleAvatar(
            //                 backgroundImage: AssetImage(
            //                   "assets/images/ratedWorker1.png",
            //                 ),
            //               )),
            //               // if (state.workers[index].isVerified)
            //               Positioned(
            //                 top: 0,
            //                 right: 0,
            //                 child: SvgPicture.asset(
            //                   AppAssetLinks.verifiedBlueSvg,
            //                 ),
            //               ),
            //               Positioned(
            //                   bottom: 0,
            //                   left: 4,
            //                   child: SvgPicture.asset(
            //                       AppAssetLinks.chatGreyBubbleSvg)),
            //             ],
            //           ),
            //         ),
            //         title: Text("John Burke",
            //             style: Theme.of(context).textTheme.headlineSmall),
            //         subtitle: const Text("Thank you for choosing me.",
            //             style: chatSubTitle),
            //         trailing: const Text("29/02/24", style: chatTrailingActive),
            //       ),
            //     ],
            //   ),
            // )
          ]),
        ));
  }
}
