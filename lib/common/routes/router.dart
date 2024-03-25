import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_routes.dart';
import 'package:quikhyr/common/routes/screens/page_not_found.dart';
import 'package:quikhyr/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr/features/auth/presentation/screens/welcome_screen.dart';
import 'package:quikhyr/features/booking/presentation/screens/booking_screen.dart';
import 'package:quikhyr/features/chat/blocs/bloc/chat_list_bloc.dart';
import 'package:quikhyr/features/chat/data/chat_repo.dart';
import 'package:quikhyr/features/chat/presentation/screens/chat_conversation_screen.dart';
import 'package:quikhyr/features/chat/presentation/screens/chat_screen.dart';
import 'package:quikhyr/features/explore/blocs/cubit/filter_chip_cubit.dart';
import 'package:quikhyr/features/explore/presentation/screens/explore_screen.dart';
import 'package:quikhyr/features/home/blocs/bloc/services_category_bloc.dart';
import 'package:quikhyr/features/home/presentation/screens/home/home_screen.dart';
import 'package:quikhyr/features/home/presentation/screens/home_detail/home_detail_screen.dart';
import 'package:quikhyr/features/settings/presentation/screens/settings_screen.dart';
import 'package:quikhyr/main_wrapper.dart';
import 'package:quikhyr/models/client_model.dart';
import 'package:quikhyr/models/service_category_model.dart';
import 'package:quikhyr/models/worker_model.dart';

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
  static final _shellNavigatorSettingsKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
  static final GoRouter _router = GoRouter(
    initialLocation: QuikRoutes.homeNamedPagePath,
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
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                if (authState.status == AuthenticationStatus.authenticated) {
                  // debugPrint("Going to Main Wrapper");
                  debugPrint(
                      navigationShell.shellRouteContext.route.toString());
                  return MainWrapper(
                    navigationShell: navigationShell,
                  );
                } else {
                  return const WelcomeScreen();
                }
              },
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
                navigatorKey: _shellNavigatorHomeKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: QuikRoutes.homeNamedPagePath,
                    name: QuikRoutes.homeNamedPageName,
                    pageBuilder: (context, state) {
                      context
                          .read<ServicesCategoryBloc>()
                          .add(LoadServicesCategories());
                      return NoTransitionPage(
                          child: HomeScreen(
                        key: state.pageKey,
                      ));
                    },
                    routes: [
                      GoRoute(
                        path:
                            '${QuikRoutes.homeDetailsFromSearchNamedPagePath}/:service/:subService',
                        name: QuikRoutes.homeDetailsFromSearchNamedPageName,
                        //navigation is done through routes so please make sure to supply a name

                        pageBuilder: (context, state) {
                          // final ServiceCategoryModel serviceModel =
                          // state.extra as ServiceCategoryModel;
                          final service = state.pathParameters['service']!;
                          final subService =
                              state.pathParameters['subService'] ??
                                  "No SubService";
                          return CustomTransitionPage<void>(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(-1, 0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              child: HomeDetailScreen(
                                  // serviceModel: serviceModel,
                                  key: state.pageKey,
                                  service: service,
                                  subService: subService));
                        },
                      ),
                      GoRoute(
                        path: '${QuikRoutes.homeDetailsNamedPagePath}/:service',
                        name: QuikRoutes.homeDetailsNamedPageName,
                        //navigation is done through routes so please make sure to supply a name

                        pageBuilder: (context, state) {
                          // final ServiceCategoryModel serviceModel =
                          // state.extra as ServiceCategoryModel;
                          final service =
                              state.pathParameters['service'] ?? "No Service";
                          return CustomTransitionPage<void>(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(-1, 0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              child: HomeDetailScreen(
                                // serviceModel: serviceModel,
                                key: state.pageKey, service: service,
                              ));
                        },
                      ),
                    ],
                  ),
                ]),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorExploreKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.exploreNamedPagePath,
                  name: QuikRoutes.exploreNamedPageName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    //ADD FILTERCHIP PROVIDER TO TRY OUT NOT PUTTING ALL BLOCS IN MAIN FILE
                    child: BlocProvider(
                      create: (context) => FilterChipCubit(),
                      child: ExploreScreen(
                        key: state.pageKey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorChatKey,
              routes: <RouteBase>[
                GoRoute(
                    path: QuikRoutes.chatNamedPagePath,
                    name: QuikRoutes.chatNamedPageName,
                    pageBuilder: (context, state) {
                      // final WorkerModel worker =
                      //     state.extra as WorkerModel;
                      //!? I guess not needed above 2 lines
                      return NoTransitionPage(
                        child: ChatScreen(key: state.pageKey),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: QuikRoutes.chatConversationNamedPagePath,
                        name: QuikRoutes.chatConversationNamedPageName,
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          // key: state.pageKey,
                          child: ChatConversationScreen(
                            worker: state.extra as ClientModel,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(
                                  -1, 0), // Modified: Start from left (-1, 0)
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBookKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.bookNamedPagePath,
                  name: QuikRoutes.bookNamedPageName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: BookingScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSettingsKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.settingsNamedPagePath,
                  name: QuikRoutes.settingsNamedPageName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: SettingsScreen(key: state.pageKey),
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
