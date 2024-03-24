import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/routes/router.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'QuikHyr',
      theme: AppTheme.appTheme,
    );
  }
}


