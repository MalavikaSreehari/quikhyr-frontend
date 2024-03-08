import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/common/constants/app_routes.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.homeNamedPage, index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(bottomNavItems: Routes.homeNamedPage,index:  0));
        break;
      case 1:
        emit(const NavigationState(bottomNavItems: Routes.exploreNamedPage,index:  1));
        break;
      case 2:
        emit(const NavigationState(bottomNavItems: Routes.chatNamedPage,index:  2));
        break;
      case 3:
        emit(const NavigationState(bottomNavItems: Routes.bookNamedPage,index:  3));
        break;
      case 4:
        emit(const NavigationState(bottomNavItems: Routes.profileNamedPage,index:  4));
        break;
    }
  }
}
