import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

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
                      style: TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                    ),
                    TextSpan(
                      text: 'uik',
                      style: TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                    ),
                    TextSpan(
                      text: 'Book',
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
                onTap: () {
                  //HANDLE GO TO NOTIFICATIONS
                }),
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
    ));
  }
}
