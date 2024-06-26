import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/constants/quik_asset_constants.dart';
import '../../../../common/constants/quik_colors.dart';
import '../../../../common/constants/quik_spacings.dart';
import '../../../../common/widgets/clickable_svg_icon.dart';
import '../../../../common/widgets/quik_app_bar.dart';
import '../../../../common/widgets/quik_search_bar.dart';
import '../../blocs/cubit/filter_chip_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> _mostSearched = [
      "Lawn Management",
      "Cleaning",
      "Plumbing",
      "Auto Repair",
      "Electricals",
      "Tree Climber"
    ];
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: QuikAppBar(
          showPageName: true,
          pageName: 'Explore',
          trailingWidgets: [
            ClickableSvgIcon(
                svgAsset: QuikAssetConstants.filterSvg,
                onTap: () {
                  //HANDLE FILTER
                }),
          ],
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
                QuikSpacing.vS16(),
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
                              selectedColor: buttonDark,
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
                              selectedColor: buttonDark,
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
                              selectedColor: buttonDark,
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
                              selectedColor: buttonDark,
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
                QuikSpacing.vS32(),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset:
                                    QuikAssetConstants.closeRoundedSquareSvg,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset:
                                    QuikAssetConstants.closeRoundedSquareSvg,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset:
                                    QuikAssetConstants.closeRoundedSquareSvg,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              trailing: ClickableSvgIcon(
                                svgAsset:
                                    QuikAssetConstants.closeRoundedSquareSvg,
                                onTap: () {},
                              ),
                            )
                          ]),
                    ),
                    QuikSpacing.vS24(),
                    Text(
                      "Most Searched",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    QuikSpacing.vS24(),
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
                      itemCount: _mostSearched.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String itemName = _mostSearched[index];
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
                            itemName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
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
