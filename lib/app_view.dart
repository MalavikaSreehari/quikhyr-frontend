import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr/common/constants/app_theme.dart';
import 'package:quikhyr/common/routes/router.dart';
import 'package:quikhyr/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr/features/auth/presentation/screens/welcome_screen.dart';
import 'package:quikhyr/features/home/presentation/screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'Firebase Auth',
      theme: AppTheme.appTheme,
    );
  }
}


