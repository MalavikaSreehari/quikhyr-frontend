import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/routes/screens/page_not_found.dart';

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
  static const signUpNamedPage = '/signup';
  static const settingsNamedPage = '/settings';

  static const homeNamedPageName = 'homeName';
  static const homeDetailsNamedPageName = 'homeDetailsName';
  static const profileNamedPageName = 'profileName';
  static const exploreNamedPageName = 'exploreName';
  static const chatNamedPageName = 'chatName';
  static const chatConversationNamedPageName = 'chatConversationName';
  static const bookNamedPageName = 'bookName';
  static const loginNamedPageName = 'loginName';
  static const signUpNamePageName = 'signupName';
  static const settingsNamedPageName = 'settingsName';


    static Widget errorWidget(BuildContext context, GoRouterState state) => const NotFoundScreen();
}
