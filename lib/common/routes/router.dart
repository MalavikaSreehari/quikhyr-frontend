import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_routes.dart';
import 'package:quikhyr/common/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:quikhyr/common/routes/screens/page_not_found.dart';
import 'package:quikhyr/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:quikhyr/features/auth/presentation/screens/welcome_screen.dart';
import 'package:quikhyr/features/booking/presentation/screens/booking_screen.dart';
import 'package:quikhyr/features/chat/presentation/screens/chat_screen.dart';
import 'package:quikhyr/features/explore/presentation/screens/explore_screen.dart';
import 'package:quikhyr/features/home/presentation/screens/home/home_screen.dart';
import 'package:quikhyr/features/home/presentation/screens/home_detail/home_detail_screen.dart';
import 'package:quikhyr/features/profile/presentation/screens/profile_screen.dart';
import 'package:quikhyr/main_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeNamedPage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
              if (authState.status == AuthenticationStatus.authenticated) {
                return BlocProvider(
                  create: (context) => NavigationCubit(),
                  child: MainScreen(screen: child),
                );
              }
              return const WelcomeScreen();
            },
          );
        },
        routes: [
          GoRoute(
            path: Routes.homeNamedPage,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: Routes.homeDetailsNamedPage,
                builder: (context, state) => const HomeDetailsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: Routes.exploreNamedPage,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExploreScreen(),
            ),
          ),
          GoRoute(
            path: Routes.chatNamedPage,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChatScreen(),
            ),
          ),
          GoRoute(
            path: Routes.bookNamedPage,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookingScreen(),
            ),
          ),
          GoRoute(
            path: Routes.profileNamedPage,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
          
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}
