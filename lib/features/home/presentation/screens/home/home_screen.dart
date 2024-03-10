import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:quikhyr/common/widgets/rating_star_worker.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr/features/home/blocs/bloc/most_rated_workers_bloc.dart';
import 'package:quikhyr/features/home/blocs/bloc/services_category_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                      ),
                      TextSpan(
                        text: 'uik',
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                      ),
                      TextSpan(
                        text: 'Hyr',
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
                  svgAsset: AppAssetLinks.bellNotificationActiveSvg,
                  onTap: () {
                    //HANDLE GO TO NOTIFICATIONS
                  }),
              AppSizing.hS10(),
              ClickableSvgIcon(
                  svgAsset: AppAssetLinks.logoutSvg,
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              AppSizing.hS24(),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar(
          //     pinned: true,
          //     expandedHeight: 100.0,
          //     flexibleSpace:
          //         Container(height: 100, width: 40, color: Colors.green)),
          // //3
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  QuikSearchBar(
                      onChanged: (String value) {},
                      hintText: "Search for services..",
                      onMicPressed: () {},
                      onSearch: (String query) {},
                      controller: TextEditingController()),

                  AppSizing.vS16(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_pin, color: primary, size: 16),
                      AppSizing.hS6(),
                      Text(
                        "Irinjalakuda",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 16,
                      )
                    ],
                  ),
                  // AppSizing.vS16(), // This is your container
                ],
              ),
            ),
          ),
          // SliverAppBar(
          //     foregroundColor: Colors.white,
          //     surfaceTintColor: Colors.white,
          //     pinned: true,
          //     expandedHeight: 50.0,
          //     flexibleSpace: Container(
          //       height: 50,
          //       width: 40,
          //       color: Colors.transparent,
          //       child: Center(
          //         child: Container(
          //           color: Colors.grey,
          //           width: 40,
          //           height: 2,
          //         ),
          //       ),
          //     )),
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: Column(
              children: [
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.grey.withOpacity(0.5),
                        Colors.grey.withOpacity(1),
                        Colors.grey.withOpacity(1),
                        Colors.grey.withOpacity(1),
                        Colors.grey.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                AppSizing.vS16(),
                Container(
                  width: 40,
                  height: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: AppSizing.vS30(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: RichText(
                text: TextSpan(
                  text: "POPULAR ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "SERVICES",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppSizing.vS24(),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: BlocBuilder<ServicesCategoryBloc, ServicesCategoryState>(
              builder: (context, state) {
                if (state is ServicesCategoryLoaded) {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 84,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      crossAxisCount: 4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: gridItemBackgroundColor),
                              alignment: Alignment.center,
                              height: 64,
                              width: 64,
                              child: SvgPicture.asset(
                                state.servicesCategory[index].iconPath,
                                height: 24,
                              )),
                          AppSizing.vS8(),
                          Text(
                            state.servicesCategory[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      );
                    }, childCount: state.servicesCategory.length),
                  );
                } else if (state is ServicesCategoryLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is ServicesCategoryError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("Failure"),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: AppSizing.vS48(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: RichText(
                text: TextSpan(
                  text: "RECENT ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "FAVOURITES",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppSizing.vS24(),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 104,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  crossAxisCount: 4,
                ),
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: gridItemBackgroundColor),
                          alignment: Alignment.center,
                          height: 64,
                          width: 64,
                          child: SvgPicture.asset(
                            AppAssetLinks.cleaningSvg,
                            height: 24,
                          )),
                      AppSizing.vS8(),
                      Text(
                        "Plumbing",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: gridItemBackgroundColor,
                        ),
                        alignment: Alignment.center,
                        height: 64,
                        width: 64,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/ratedWorker3.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      AppSizing.vS8(),
                      Text(
                        "Henry Kal",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      AppSizing.vS4(),
                      Text(
                        "Electrician",
                        // overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: gridItemBackgroundColor),
                          alignment: Alignment.center,
                          height: 64,
                          width: 64,
                          child: SvgPicture.asset(
                            AppAssetLinks.lawnMangementSvg,
                            height: 24,
                          )),
                      AppSizing.vS8(),
                      Text(
                        "Lawn Management",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                ]),
              )),
          SliverToBoxAdapter(
            child: AppSizing.vS48(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: RichText(
                text: TextSpan(
                  text: "MOST RATED ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "WORKERS",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppSizing.vS24(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: BlocBuilder<MostRatedWorkersBloc, MostRatedWorkersState>(
              builder: (context, state) {
                if (state is MostRatedWorkersLoaded) {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 104,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      crossAxisCount: 4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: gridItemBackgroundColor,
                              ),
                              alignment: Alignment.center,
                              height: 64,
                              width: 64,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipOval(
                                      child: Image.asset(
                                        state.workers[index].profileImageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (state.workers[index].isVerified)
                                    const Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.verified_rounded,
                                        color: primary,
                                        size: 16,
                                      ),
                                    ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: RatingStar(
                                        rating: state.workers[index].rating
                                            .toString()),
                                  ),
                                ],
                              ),
                            ),
                            AppSizing.vS8(),
                            Text(
                              state.workers[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            AppSizing.vS4(),
                            Text(
                              state.workers[index].category,
                              // overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          ],
                        );
                      },
                      childCount: state.workers.length,
                    ),
                  );
                } else if (state is MostRatedWorkersLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is MostRatedWorkersError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("Failure"),
                  ),
                );
              },
            ),
          ),

          //? UNCOMMENT THIS TO GET THE GRID VIEW OF POPULAR SERVICES
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   sliver: SliverGrid(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       mainAxisExtent: 84,
          //       mainAxisSpacing: 20.0,
          //       crossAxisSpacing: 20.0,
          //       crossAxisCount: 4,
          //     ),
          //     delegate:
          //         SliverChildBuilderDelegate((BuildContext context, int index) {
          //       return Column(
          //         children: [
          //           Container(
          //               decoration: const BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: gridItemBackgroundColor),
          //               alignment: Alignment.center,
          //               height: 64,
          //               width: 64,
          //               child: SvgPicture.asset(
          //                 AppAssetLinks.plumbingSvg,
          //                 height: 24,
          //               )),
          //           AppSizing.vS8(),
          //           Text(
          //             "Plumbing",
          //             style: Theme.of(context).textTheme.labelLarge,
          //           )
          //         ],
          //       );
          //     }, childCount: 6
          //     ),
          //   ),
          // )

          // SliverFixedExtentList.builder(
          //   itemCount: 10,
          //   itemBuilder: (context, index) {
          //     return Column(children: [
          //       Container(
          //         color: Colors.white,
          //         height: 100.0,
          //         child: Center(
          //           child: Text('Item $index'),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       )
          //     ]);
          //   },
          //   itemExtent: 300,
          // ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      //       child: Column(
      //         children: [
      //           Column(
      //             children: [
      //               SearchBar(
      //                   leading: const Padding(
      //                       padding: EdgeInsets.only(left: 12),
      //                       child: Icon(Icons.search)),
      //                   trailing: [
      //                     const SizedBox(),
      //                     IconButton(
      //                       icon: const Icon(Icons.mic),
      //                       onPressed: () {
      //                         // Handle voice search
      //                       },
      //                     ),
      //                   ]),
      //               AppSizing.vS16(),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   const Icon(Icons.location_pin,
      //                       color: primary, size: 16),
      //                   AppSizing.hS6(),
      //                   Text(
      //                     "Irinjalakuda",
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .headlineSmall
      //                         ?.copyWith(fontWeight: FontWeight.w700),
      //                   ),
      //                   const Icon(
      //                     Icons.arrow_drop_down_outlined,
      //                     size: 16,
      //                   )
      //                 ],
      //               ),
      //               AppSizing.vS16(),
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               Container(
      //                 height: 0.5,
      //                 decoration: BoxDecoration(
      //                   gradient: LinearGradient(
      //                     colors: [
      //                       Colors.transparent,
      //                       Colors.grey.withOpacity(0.5),
      //                       Colors.grey.withOpacity(1),
      //                       Colors.grey.withOpacity(1),
      //                       Colors.grey.withOpacity(1),
      //                       Colors.grey.withOpacity(0.5),
      //                       Colors.transparent,
      //                     ],
      //                     begin: Alignment.centerLeft,
      //                     end: Alignment.centerRight,
      //                   ),
      //                 ),
      //               ),
      //               AppSizing.vS16(),
      //               Container(
      //                 width: 40,
      //                 height: 2,
      //                 color: Colors.grey,
      //               ),
      //             ],
      //           ),
      //           Container(
      //             height: 500,
      //             child: ListView.builder(
      //               itemCount: 20,
      //               itemBuilder: (BuildContext context, int index) {
      //                 return Container(
      //                   height: 100,
      //                   color: Colors.grey,
      //                   margin: const EdgeInsets.symmetric(vertical: 8),
      //                 );
      //               },
      //             ),
      //           )
      //         ],
      //       )),
      // ),
    );
  }
}
