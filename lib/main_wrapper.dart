import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_routes.dart';
import 'package:quikhyr/common/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:quikhyr/common/widgets/named_nav_bar_item_widget.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key, required this.navigationShell})
      : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;
  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  final tabs = [
    NamedNavigationBarItemWidget(
      activeIcon: SvgPicture.asset(
        AppAssetLinks.homeNavBarActiveSvg,
      ),
      initialLocation: Routes.homeNamedPage,
      icon: SvgPicture.asset(
        AppAssetLinks.homeNavBarSvg,
      ),
      label: 'Home',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: SvgPicture.asset(
        AppAssetLinks.exploreNavBarActiveSvg,
      ),
      initialLocation: Routes.exploreNamedPage,
      icon: SvgPicture.asset(
        AppAssetLinks.exploreNavBarSvg,
      ),
      label: 'Explore',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: SvgPicture.asset(
        AppAssetLinks.chatNavBarActiveSvg,
      ),
      initialLocation: Routes.chatNamedPage,
      icon: SvgPicture.asset(
        AppAssetLinks.chatNavBarSvg,
      ),
      label: 'Chat',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: SvgPicture.asset(
        AppAssetLinks.bookNavBarActiveSvg,
      ),
      initialLocation: Routes.bookNamedPage,
      icon: SvgPicture.asset(
        AppAssetLinks.bookNavBarSvg,
      ),
      label: 'Bookmark',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: SvgPicture.asset(
        AppAssetLinks.profileNavBarActiveSvg,
      ),
      initialLocation: Routes.profileNamedPage,
      icon: SvgPicture.asset(
        AppAssetLinks.profileNavBarSvg,
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      // bottomNavigationBar: _buildBottomNavigation(context, tabs),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.black,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            //if having lag move _goToBranch(index) to the bottom of the setState
            _goToBranch(index);
          });
        },
      ),
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
            // if (state.index != value) {
            //   context.read<NavigationCubit>().getNavBarItem(value);
            //   context.go(tabs[value].initialLocation);
            // }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          // selectedIconTheme: IconThemeData(
          //   size: ((IconTheme.of(mContext).size)! * 1.3),
          // ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
