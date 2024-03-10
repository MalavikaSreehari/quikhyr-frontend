import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Q',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                        ),
                        TextSpan(
                          text: 'uik',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                        ),
                        TextSpan(
                          text: 'Explore',
                          style: TextStyle(
                              fontFamily: 'Trap',
                              fontSize: 24,
                              letterSpacing: -1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ClickableSvgIcon(
                    svgAsset: AppAssetLinks.filterSvg,
                    onTap: () {
                      //HANDLE GO TO NOTIFICATIONS
                    }),
                AppSizing.hS24(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              QuikSearchBar(
                onChanged: (String onChanged) {},
                hintText: 'Search for services..',
                onMicPressed: () {},
                onSearch: (String value) {},
                controller: TextEditingController(),
              ),
              AppSizing.vS16(),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: const Text(
                          'All',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: true,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool value) {
                          // handle chip selection
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: const Text(
                          'Highly Rated',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: false,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool value) {
                          // handle chip selection
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: const Text(
                          'Low Budget',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: true,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool value) {
                          // handle chip selection
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: const Text(
                          'Medium Budget',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: false,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool value) {
                          // handle chip selection
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
