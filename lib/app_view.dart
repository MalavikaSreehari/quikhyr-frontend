import 'package:flutter/material.dart';
import 'common/constants/quik_themes.dart';
import 'common/routes/router.dart';
import 'features/chat/notification_service.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  final notificationService = NotificationsService();

  @override
  void initState() {
   notificationService.firebaseNotification(context);
    super.initState();
  }

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


