import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_app_bar.dart';
import 'package:quikhyr/common/widgets/quik_short_button.dart';

import '../../../../common/widgets/quik_small_text_with_border.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuikAppBar(
        onlyHasTitle: true,
        showBackButton: true,
        showPageName: false,
        title: 'Henry Kal',
        trailingWidgets: [
          QuikSmallTextWithBorder(
            text: 'Available',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const GradientSeparator(),
            QuikSpacing.vS24(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Henry Kal",
                      style: largeHeadingTextStyle,
                    ),
                    QuikSpacing.vS12(),
                    Text(
                      "Plumber, Mechanic",
                      style: subtitleMediumTextStyle,
                    ),
                    QuikSpacing.vS16(),
                    Text("Irinjalakuda", style: subtitleMediumPrimaryTextStyle)
                  ],
                ),
                const Spacer(),
                Container(
                  height: 100,
                  width: 100,
                  child: Image.network(QuikAssetConstants.placeholderImage),
                )
              ],
            ),
            QuikSpacing.vS24(),
            Row(
              children: [
                QuikShortButton(
                  text: "Message",
                  svgPath: QuikAssetConstants.sendSvg,
                  onPressed: () {},
                )
              ],
            ),
            QuikSpacing.vS32(),
            Text(
              "ABOUT",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            QuikSpacing.vS16(),
            Text(
              "I am a highly skilled and experienced plumber and mechanic with over 10 years of experience in the field. I am proficient in all aspects of",
              style: descriptionTextStyle,
            )
          ]),
        ),
      ),
    );
  }
}
