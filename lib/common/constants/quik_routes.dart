import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/routes/screens/page_not_found.dart';

class QuikRoutes {
  static const root = '/';
  static const homePath = '/home';
  static const homeDetailsPath = 'details';
  static const homeDetailsFromSearchPath = 'detailsFromSearch';
  static const profilePath = '/profile';
  static const explorePath = '/explore';
  static const chatPath = '/chat';
  static const chatConversationPath = 'conversation';
  static const bookPath = '/book';
  static const loginPath = 'login';
  static const signUpPath = '/signup';
  static const signInPath = '/signin';
  static const settingsPath = '/settings';
  static const welcomePath = '/welcome';

  static const homeName = 'homeName';
  static const homeDetailsName = 'homeDetailsName';
  static const homeDetailsFromSearchName = 'homeDetailsFromSearchName';
  static const profileName = 'profileName';
  static const exploreName = 'exploreName';
  static const chatName = 'chatName';
  static const chatConversationName = 'chatConversationName';
  static const bookName = 'bookName';
  static const loginName = 'loginName';
  static const signUpName = 'signupName';
  static const signInName = 'signinName';
  static const settingsName = 'settingsName';
  static const welcomeName = 'welcomeName';

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}
