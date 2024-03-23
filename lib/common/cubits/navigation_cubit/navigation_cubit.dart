// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:quikhyr/common/constants/app_routes.dart';

// part 'navigation_state.dart';

// class NavigationCubit extends Cubit<NavigationState> {
//   NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.homeNamedPagePath, index: 0));

//   void getNavBarItem(int index) {
//     switch (index) {
//       case 0:
//         emit(const NavigationState(bottomNavItems: Routes.homeNamedPagePath,index:  0));
//         break;
//       case 1:
//         emit(const NavigationState(bottomNavItems: Routes.exploreNamedPagePath,index:  1));
//         break;
//       case 2:
//         emit(const NavigationState(bottomNavItems: Routes.chatNamedPagePath,index:  2));
//         break;
//       case 3:
//         emit(const NavigationState(bottomNavItems: Routes.bookNamedPagePath,index:  3));
//         break;
//       case 4:
//         emit(const NavigationState(bottomNavItems: Routes.profileNamedPagePath,index:  4));
//         break;
//     }
//   }
// }
