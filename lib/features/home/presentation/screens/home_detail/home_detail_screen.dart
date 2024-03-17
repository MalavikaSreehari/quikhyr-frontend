// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/constants/app_theme.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';

import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr/models/service_category_model.dart';

class HomePopularServicesDetailScreen extends StatelessWidget {
  final ServiceCategoryModel serviceModel;
  const HomePopularServicesDetailScreen({
    Key? key,
    required this.serviceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              leading: const Icon(Icons.arrow_back_ios_new, color: secondary),
              titleSpacing: 24,
              // automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: gridItemBackgroundColor),
                      alignment: Alignment.center,
                      height: 36,
                      width: 36,
                      child: SvgPicture.asset(
                        serviceModel.iconPath,
                      )),
                  AppSizing.hS12(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(serviceModel.title,
                          style: Theme.of(context).textTheme.titleLarge),
                      AppSizing.vS8(),
                      const Text("Service", style: chatSubTitle),
                    ],
                  )
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
        body: Center(child: Text(serviceModel.title)));
  }
}
