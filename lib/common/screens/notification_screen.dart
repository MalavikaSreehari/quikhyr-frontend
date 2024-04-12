import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_routes.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/constants/app_theme.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                      ),
                      TextSpan(
                        text: 'uik',
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                      ),
                      TextSpan(
                        text: 'Notifications',
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
                  svgAsset: AppAssetLinks.logoutSvg,
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              AppSizing.hS24(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.builder(
          itemCount: 5, 
          itemBuilder: (context, index) {
            return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        alignment: Alignment.center,
        height: 64,
        width: 64,
        child: CircleAvatar(
                  backgroundImage: NetworkImage(
        AppAssetLinks.placeholderImage,
                  ),
                ),
      ),
      title: Text("Worker Name",
          style: Theme.of(context).textTheme.headlineSmall),
      subtitle: Text("Service Time: 12:00 pm", style: chatSubTitle),
      trailing: const Text(
        "Price",
        style: chatTrailingActive,
      ),
      onTap: () {
        showModalBottomSheet(context: context, builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ListTile(
                  title: Text("Worker Name"),
                  subtitle: Text("Service Time: 12:00 pm"),
                  trailing: Text("Price"),
                  
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed(Routes.chatConversationNamedPageName);
                      },
                      child: Text("Accept"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed(Routes.chatConversationNamedPageName);
                      },
                      child: Text("Reject"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        });
      },
    );

          },
        ),
      ),
    );
  }
}