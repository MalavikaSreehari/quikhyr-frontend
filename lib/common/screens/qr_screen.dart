import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

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
            // actions: [
            //   ClickableSvgIcon(
            //       svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
            //       onTap: () {
            //         context.pushNamed(QuikRoutes.notificationName);
            //         // BookingRepository().getBookingsById(
            //         //     FirebaseAuth.instance.currentUser!.uid);
            //       }),
            //   QuikSpacing.hS10(),
            //   ClickableSvgIcon(
            //       svgAsset: QuikAssetConstants.logoutSvg,
            //       onTap: () {
            //         // context.read<SignInBloc>().add(const SignOutRequired());
            //       }),
            //   QuikSpacing.hS24(),
            // ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuikSearchBar(
              controller: TextEditingController(),
              onMicPressed: () {},
              onChanged: (p0) {},
              hintText: 'Search for bookings..',
              onSearch: (value) {
                // context.read<SearchBloc>().add(SearchService(value));
              },
            ),
            QuikSpacing.vS36(),
            const GradientSeparator(),
            QuikSpacing.vS24(),
            Text(
              "SCAN QR CODE",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            QuikSpacing.vS32(),
            const Text(
              "Show this QR Code to the worker, after the work has been completed.",
              style: chatSubTitleRead,
            ),
            QuikSpacing.vS32(),
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child:
                        SvgPicture.asset(QuikAssetConstants.qrCodeLargeSvg))),
          ],
        ),
      ),
    );
  }
}
