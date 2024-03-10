import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
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
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssetLinks.homeNavBarActiveSvg,
          ),
          AppSizing.hS8(),
          Text("Home", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        AppAssetLinks.homeNavBarSvg,
      ),
      label: 'Home',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssetLinks.exploreNavBarActiveSvg,
          ),
          AppSizing.hS8(),
          Text("Explore", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        AppAssetLinks.exploreNavBarSvg,
      ),
      label: 'Explore',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssetLinks.chatNavBarActiveSvg,
          ),
          AppSizing.hS8(),
          Text("Chat", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        AppAssetLinks.chatNavBarSvg,
      ),
      label: 'Chat',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssetLinks.bookNavBarActiveSvg,
          ),
          AppSizing.hS8(),
          Text("Book", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        AppAssetLinks.bookNavBarSvg,
      ),
      label: 'Bookmark',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssetLinks.profileNavBarActiveSvg,
          ),
          AppSizing.hS8(),
          Text("Profile", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        AppAssetLinks.profileNavBarSvg,
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    
    setState(() {
      //!!RISKY CODE!!//
      if (context.canPop()){
        context.pop();
      }
    });

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
        type: BottomNavigationBarType.shifting,
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

// BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(
//         mContext, List<NamedNavigationBarItemWidget> tabs) =>
//     BlocBuilder<NavigationCubit, NavigationState>(
//       buildWhen: (previous, current) => previous.index != current.index,
//       builder: (context, state) {
//         return BottomNavigationBar(
//           onTap: (value) {
//             // if (state.index != value) {
//             //   context.read<NavigationCubit>().getNavBarItem(value);
//             //   context.go(tabs[value].initialLocation);
//             // }
//           },
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0,
//           backgroundColor: Colors.black,
//           unselectedItemColor: Colors.white,
//           // selectedIconTheme: IconThemeData(
//           //   size: ((IconTheme.of(mContext).size)! * 1.3),
//           // ),
//           items: tabs,
//           currentIndex: state.index,
//           type: BottomNavigationBarType.fixed,
//         );
//       },
//     );
