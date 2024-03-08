import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_routes.dart';
import 'package:quikhyr/common/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:quikhyr/common/widgets/named_nav_bar_item_widget.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  MainScreen({Key? key, required this.screen}) : super(key: key);

  final tabs = [
    NamedNavigationBarItemWidget(
      activeIcon: const Icon(Icons.home),
      // activeIcon: SvgPicture.asset(
      //   'images/search_active.svg',
      //   color: Colors.white,
      // ),
      initialLocation: Routes.homeNamedPage,
      // icon: SvgPicture.asset(
      //   'images/search.svg',
      //   color: Colors.white,
      // ),
      icon: const Icon(Icons.key),
      label: 'Home',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: const Icon(Icons.search_off_outlined),
      initialLocation: Routes.exploreNamedPage,
      icon: const Icon(Icons.search),
      label: 'Explore', // Set label position to right
    ),
    NamedNavigationBarItemWidget(
      activeIcon: const Icon(Icons.chat_bubble_outline),
      initialLocation: Routes.chatNamedPage,
      icon: const Icon(Icons.chat),
      label: 'Chat',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: const Icon(Icons.bookmark),
      initialLocation: Routes.bookNamedPage,
      icon: const Icon(Icons.book_online_outlined),
      label: 'Bookmark',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: const Icon(Icons.person),
      initialLocation: Routes.bookNamedPage,
      icon: const Icon(Icons.person_4),
      label: 'Bookmark',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, tabs),
    );
  }
}

BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(
        mContext, List<NamedNavigationBarItemWidget> tabs) =>
    BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (value) {
            if (state.index != value) {
              context.read<NavigationCubit>().getNavBarItem(value);
              context.go(tabs[value].initialLocation);
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            size: ((IconTheme.of(mContext).size)! * 1.3),
          ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
