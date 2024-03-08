import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/routes/screens/page_not_found.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class Routes {
  static const root = '/';
  static const homeNamedPage = '/home';
  static const homeDetailsNamedPage = 'details';
  static const profileNamedPage = '/profile';
  static const exploreNamedPage = '/explore';
  static const chatNamedPage = '/chat';
  static const chatConversationNamedPage = 'conversation';
  static const bookNamedPage = '/book';
  static const loginNamedPage = '/login';
  static const signUpNamePage = '/signup';

    static Widget errorWidget(BuildContext context, GoRouterState state) => const NotFoundScreen();
}
