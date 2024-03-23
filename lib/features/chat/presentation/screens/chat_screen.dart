import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:quikhyr/features/chat/firebase_provider.dart';
import 'package:quikhyr/features/chat/presentation/components/user_item.dart';
import 'package:quikhyr/models/location_model.dart';
import 'package:quikhyr/models/worker_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false);
    super.initState();
  }

  final userData = [
    WorkerModel(
      id: '1',
      name: 'John Doe',
      age: 35,
      available: true,
      avatar: AppAssetLinks.placeholderImage,
      email: 'john.doe@example.com',
      gender: 'Male',
      location: LocationModel(
        latitude: "40.7348",
        longitude: "74.3360",
      ),
      phone: '123-456-7890',
      pincode: '10001',
      subservices: const ["ZbpkeckdBSht7GOR1T9y"],
    ),
    WorkerModel(
      id: '2',
      name: 'Jane Smith',
      age: 30,
      available: false,
      avatar: AppAssetLinks.placeholderImage,
      email: 'jane.smith@example.com',
      gender: 'Female',
      location: LocationModel(
        latitude: "40.7128",
        longitude: "74.0060",
      ),
      phone: '098-765-4321',
      pincode: '90001',
      subservices: const ["ZbpkeckdBSht7GOR1T9y"],
    ),
  ];
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
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => const GradientSeparator(),
              itemBuilder: (context, index) {
                return UserItem(
                  worker: userData.elementAt(index),
                );
              },
              itemCount: userData.length,
            )),

            // Expanded(
            //   child: ListView(
            //     shrinkWrap: true,
            //     children: [
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: Container(
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: gridItemBackgroundColor,
            //     ),
            //     alignment: Alignment.center,
            //     height: 64,
            //     width: 64,
            //     child: Stack(
            //       children: [
            //         const Positioned.fill(
            //             child: CircleAvatar(
            //           backgroundImage: AssetImage(
            //             "assets/images/ratedWorker2.png",
            //           ),
            //         )),
            //         // if (state.workers[index].isVerified)
            //         Positioned(
            //           top: 0,
            //           right: 0,
            //           child: SvgPicture.asset(
            //             AppAssetLinks.verifiedBlueSvg,
            //           ),
            //         ),
            //         Positioned(
            //             bottom: 0,
            //             left: 4,
            //             child: SvgPicture.asset(
            //                 AppAssetLinks.chatGreenBubbleSvg)),
            //       ],
            //     ),
            //   ),
            //   title: Text("Kenny Kirk",
            //       style: Theme.of(context).textTheme.headlineSmall),
            //   subtitle: const Text("Will meet you tomorrow.",
            //       style: chatSubTitle),
            //   trailing: const Text(
            //     "7:04 pm",
            //     style: chatTrailingActive,
            //   ),
            //   onTap: () =>
            //       context.pushNamed(Routes.chatConversationNamedPageName),
            // ),
            // const GradientSeparator(),
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
