import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/screens/feedback_screen.dart';
import 'package:quikhyr/models/worker_model.dart';
import '../../models/notification_model.dart';
import '../constants/quik_routes.dart';
import '../screens/notification_detail_screen.dart';
import 'screens/page_not_found.dart';
import '../screens/notification_screen.dart';
import '../screens/qr_screen.dart';
import '../../features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/booking/presentation/screens/booking_detail_screen.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/chat/presentation/screens/chat_conversation_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/explore/blocs/cubit/filter_chip_cubit.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/home/models/immediate_screen_data_model.dart';
import '../../features/home/presentation/screens/home/home_screen.dart';
import '../../features/home/presentation/screens/home_detail/home_detail_screen.dart';
import '../../features/home/presentation/screens/immediate_booking_screen.dart';
import '../../features/home/presentation/screens/map_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../main_wrapper.dart';
import '../../models/booking_model.dart';
import '../../models/location_model.dart';
import '../../models/service_category_model.dart';

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
    initialLocation: QuikRoutes.homePath,
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
                    path: QuikRoutes.homePath,
                    name: QuikRoutes.homeName,
                    pageBuilder: (context, state) {
                      // context
                      //     .read<ServicesCategoryBloc>()
                      //     .add(LoadServicesCategories());
                      return NoTransitionPage(
                          child: HomeScreen(
                        key: state.pageKey,
                      ));
                    },
                    routes: [
                      GoRoute(
                        path:
                            '${QuikRoutes.homeDetailsFromSearchPath}/:service/:subService',
                        name: QuikRoutes.homeDetailsFromSearchName,
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
                        path: QuikRoutes.homeDetailsPath,
                        name: QuikRoutes.homeDetailsName,
                        //navigation is done through routes so please make sure to supply a name

                        pageBuilder: (context, state) {
                          // final ServiceCategoryModel serviceModel =
                          // state.extra as ServiceCategoryModel;
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
                                serviceModel: state.extra as ServiceModel?,
                                key: state.pageKey,
                              ));
                        },
                      ),
                      GoRoute(
                        path: QuikRoutes.homeImmediateBookingPath,
                        name: QuikRoutes.homeImmediateBookingName,
                        pageBuilder: (context, state) {
                          final immediateBookingScreenDataModel =
                              state.extra as ImmediateBookingScreenDataModel;
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
                              child: ImmediateBookingScreen(
                                immediateBookingScreenDataModel: immediateBookingScreenDataModel,
                                key: state.pageKey,
                              ));
                        },
                      ),
                      GoRoute(
                        path: QuikRoutes.mapPath,
                        name: QuikRoutes.mapName,
                        pageBuilder: (context, state) {
                          return createCustomTransitionPage(MapScreen(
                            locationModel: state.extra as LocationModel,
                                key: state.pageKey,
                              ));  
                              
                        },
                      )
                    ],
                  ),
                ]),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorExploreKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.explorePath,
                  name: QuikRoutes.exploreName,
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
                    path: QuikRoutes.chatPath,
                    name: QuikRoutes.chatName,
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
                        parentNavigatorKey: _rootNavigatorKey,
                        path: '${QuikRoutes.chatConversationPath}/:workerId',
                        name: QuikRoutes.chatConversationName,
                        pageBuilder: (context, state) =>
                            createCustomTransitionPage(ChatConversationScreen(
                                workerId: state.pathParameters['workerId']!)),
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBookKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.bookPath,
                  name: QuikRoutes.bookName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: BookingScreen(key: state.pageKey),
                  ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _shellNavigatorBookKey,
                      path: QuikRoutes.bookingDetailPath,
                      name: QuikRoutes.bookingDetailName,
                      pageBuilder: (context, state) =>
                          createCustomTransitionPage(BookingDetailScreen(
                        key: state.pageKey,
                        booking: state.extra as Booking,
                      )),
                    ),
                    GoRoute(
                        parentNavigatorKey: _shellNavigatorBookKey,
                        path: "${QuikRoutes.bookingQrPath}/:qrData",
                        name: QuikRoutes.bookingQrName,
                        pageBuilder: (context, state) {
                          return createCustomTransitionPage(QrScreen(
                              qrData: state.pathParameters['qrData'] ??
                                  'Data Fetching Error'));
                        }),
                  ],
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSettingsKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.settingsPath,
                  name: QuikRoutes.settingsName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: SettingsScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
          ]),
      GoRoute(
          path: QuikRoutes.notificationPath,
          name: QuikRoutes.notificationName,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: NotificationScreen()),
              routes: [
                   GoRoute(
          path: QuikRoutes.notificationDetailPath,
          name: QuikRoutes.notificationDetailName,
          pageBuilder: (context, state) => NoTransitionPage(
                child: NotificationDetailScreen(notification: state.extra as NotificationModel,),
              ),
              ),
              ]
              ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: QuikRoutes.signInPath,
          name: QuikRoutes.signInName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: SignInScreen());
          }),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: QuikRoutes.signUpPath,
          name: QuikRoutes.signUpName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: SignUpScreen());
          }),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: QuikRoutes.welcomePath,
          name: QuikRoutes.welcomeName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: WelcomeScreen());
          }),
      GoRoute(
          // parentNavigatorKey: _rootNavigatorKey,
          path: QuikRoutes.profilePath,
          name: QuikRoutes.profileName,
          pageBuilder: (context, state) {
            return NoTransitionPage(child: ProfileScreen(worker: state.extra as WorkerModel,));
          }),
          GoRoute(
          // parentNavigatorKey: _rootNavigatorKey,
          path: QuikRoutes.feedbackPath,
          name: QuikRoutes.feedbackName,
          pageBuilder: (context, state) {
            return NoTransitionPage(child: FeedbackScreen(booking: state.extra as Booking,),);
          }),
      

      //It is not necessary to provide a navigatorKey if it isn't also
      //needed elsewhere. If not provided, a default key will be used.
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}

CustomTransitionPage<void> createCustomTransitionPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0), // Start from left (-1, 0)
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
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
