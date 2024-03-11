import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:quikhyr/features/explore/blocs/cubit/filter_chip_cubit.dart';

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
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
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
                BlocBuilder<FilterChipCubit, FilterChipState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: const Text(
                                'All',
                                style: TextStyle(color: Colors.white),
                              ),
                              selected: state is AllState,
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              onSelected: (bool value) {
                                context.read<FilterChipCubit>().selectAll();
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: const Text(
                                'Highly Rated',
                                style: TextStyle(color: Colors.white),
                              ),
                              selected: state is HighRatedState,
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              onSelected: (bool value) {
                                context
                                    .read<FilterChipCubit>()
                                    .selectHighRated();
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: const Text(
                                'Low Budget',
                                style: TextStyle(color: Colors.white),
                              ),
                              selected: state is LowBudgetState,
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              onSelected: (bool value) {
                                context
                                    .read<FilterChipCubit>()
                                    .selectLowBudget();
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: const Text(
                                'Most Popular',
                                style: TextStyle(color: Colors.white),
                              ),
                              selected: state is MostPopularState,
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              onSelected: (bool value) {
                                context
                                    .read<FilterChipCubit>()
                                    .selectMostPopular();
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              showCheckmark: false,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                AppSizing.vS32(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Booking",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Electrical",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              subtitle: Text(
                                "Varsha Babu",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset: AppAssetLinks.closeRoundedSquareSvg,
                                onTap: () {},
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Tree Climber",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              subtitle: Text(
                                "Nikhit Kumar",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset: AppAssetLinks.closeRoundedSquareSvg,
                                onTap: () {},
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Mechanic",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              subtitle: Text(
                                "Pranav Madhu",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset: AppAssetLinks.closeRoundedSquareSvg,
                                onTap: () {},
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Electrical",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              subtitle: Text(
                                "Varsha Babu",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset: AppAssetLinks.closeRoundedSquareSvg,
                                onTap: () {},
                              ),
                            )
                          ]),
                    ),
                    AppSizing.vS24(),
                    Text(
                      "Most Searched",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    AppSizing.vS24(),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 150 / 64,
                        mainAxisSpacing:
                            12, // Set the mainAxisSpacing to 0 or a smaller value
                        crossAxisSpacing: 12.0,
                        crossAxisCount: 2,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 64,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(51, 153, 204, 0.32),
                                Color.fromRGBO(26, 77, 102, 0.32),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Lawn Management",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: secondary,
                                ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
