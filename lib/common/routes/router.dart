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
import 'package:quikhyr/main_wrapper.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorExploreKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellExplore');
  static final _shellNavigatorChatKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellChat');
  static final _shellNavigatorBookKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellBook');
  static final _shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeNamedPage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
// BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         builder: (context, authState) {
//           if (authState.status == AuthenticationStatus.authenticated) {
//             return BlocProvider(
//               create: (context) => NavigationCubit(),
//               child: MainScreen(screen: child),
//             );
//           }
//           return const WelcomeScreen();
//         },
//       );

      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainWrapper(navigationShell: navigationShell,);
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
                navigatorKey: _shellNavigatorHomeKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.homeNamedPage,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: HomeScreen(),
                    ),
                    routes: [
                      GoRoute(
                        path: Routes.homeDetailsNamedPage,
                        name: 'details',
                        //navigation is done through routes so please make sure to supply a name
                        

                        builder: (context, state) => HomeDetailsScreen(key: state.pageKey),
                      ),
                    ],
                  ),
                ]),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorExploreKey,
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.exploreNamedPage,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: ExploreScreen(key: state.pageKey,),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorChatKey,
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.chatNamedPage,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: ChatScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBookKey,
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.bookNamedPage,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: BookingScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorProfileKey,
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.profileNamedPage,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: ProfileScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
          ])
      //It is not necessary to provide a navigatorKey if it isn't also
      //needed elsewhere. If not provided, a default key will be used.
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:quikhyr/common/constants/app_routes.dart';
// import 'package:quikhyr/common/cubits/navigation_cubit/navigation_cubit.dart';
// import 'package:quikhyr/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:quikhyr/features/auth/presentation/screens/welcome_screen.dart';
// import 'package:quikhyr/features/home/presentation/screens/home/home_screen.dart';
// import 'package:quikhyr/main_screen.dart';

// class AppNavigation {
//   AppNavigation._();

//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();
//   static final _rootNavigatorHomeKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellHome');
//   static final _shellNavigatorExploreKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellExplore');
//   static final _shellNavigatorChatKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellChat');
//   static final _shellNavigatorBookKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellBook');
//   static final _shellNavigatorProfileKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
//   static final GoRouter router = GoRouter(
//       initialLocation: Routes.homeNamedPage,
//       navigatorKey: _rootNavigatorKey,
//       routes: <RouteBase>[
//         StatefulShellRoute.indexedStack(
//             builder: (context, state, child) {
//               return BlocBuilder<AuthenticationBloc, AuthenticationState>(
//                 builder: (context, authState) {
//                   if (authState.status == AuthenticationStatus.authenticated) {
//                     return BlocProvider(
//                       create: (context) => NavigationCubit(),
//                       child: MainScreen(screen: child),
//                     );
//                   }
//                   return const WelcomeScreen();
//                 },
//               );
//             },
//             branches: <StatefulShellBranch>[
//               StatefulShellBranch(navigatorKey: _rootNavigatorHomeKey, routes: [
//                 GoRoute(
//                   path: Routes.homeNamedPage,
//                   name: 'Home',
//                   builder: (context, state) {
//                     return NoTransitionPage(child: HomeScreen());
//                   },
//                 )
//               ])
//             ])
//       ]);
// }
