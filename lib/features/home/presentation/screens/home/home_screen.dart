import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                SvgPicture.asset(
                  AppAssetLinks.logoSvg,
                  height: 24,
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
                    context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              AppSizing.hS24(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                Column(
                  children: [
                    SearchBar(
                        leading: const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(Icons.search)),
                        trailing: [
                          const SizedBox(),
                          IconButton(
                            icon: const Icon(Icons.mic),
                            onPressed: () {
                              // Handle voice search
                            },
                          ),
                        ]),
                    AppSizing.vS16(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_pin,
                            color: primary, size: 16),
                        AppSizing.hS6(),
                        Text(
                          "Irinjalakuda",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 16,
                        )
                      ],
                    ),
                    AppSizing.vS16(),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.withOpacity(0.5),
                            Colors.grey.withOpacity(1),
                            Colors.grey.withOpacity(1),
                            Colors.grey.withOpacity(1),
                            Colors.grey.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    AppSizing.vS16(),
                    Container(
                      width: 40,
                      height: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 100,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
