import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/routes/screens/page_not_found.dart';

class QuikRoutes {
  static const root = '/';
  static const homeNamedPagePath = '/home';
  static const homeDetailsNamedPagePath = 'details';
  static const homeDetailsFromSearchNamedPagePath = 'detailsFromSearch';
  static const profileNamedPagePath = '/profile';
  static const exploreNamedPagePath = '/explore';
  static const chatNamedPagePath = '/chat';
  static const chatConversationNamedPagePath = 'conversation';
  static const bookNamedPagePath = '/book';
  static const loginNamedPagePath = '/login';
  static const signUpNamedPagePath = '/signup';
  static const settingsNamedPagePath = '/settings';

  static const homeNamedPageName = 'homeName';
  static const homeDetailsNamedPageName = 'homeDetailsName';
  static const homeDetailsFromSearchNamedPageName = 'homeDetailsFromSearchName';
  static const profileNamedPageName = 'profileName';
  static const exploreNamedPageName = 'exploreName';
  static const chatNamedPageName = 'chatName';
  static const chatConversationNamedPageName = 'chatConversationName';
  static const bookNamedPageName = 'bookName';
  static const loginNamedPageName = 'loginName';
  static const signUpNamePageName = 'signupName';
  static const settingsNamedPageName = 'settingsName';

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}
