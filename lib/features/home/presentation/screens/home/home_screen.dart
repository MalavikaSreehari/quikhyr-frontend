import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/bloc/client_bloc.dart';
import '../../../../../common/constants/quik_asset_constants.dart';
import '../../../../../common/constants/quik_colors.dart';
import '../../../../../common/constants/quik_routes.dart';
import '../../../../../common/constants/quik_spacings.dart';
import '../../../../../common/constants/quik_themes.dart';
import '../../../../../common/widgets/clickable_svg_icon.dart';
import '../../../../../common/widgets/quik_search_bar.dart';
import '../../../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../../notification/cubit/notification_cubit.dart';
import '../../../bloc/most_rated_workers_bloc.dart';
import '../../../bloc/search_bloc.dart';
import '../../../bloc/services_bloc.dart';
import '../../../cubit/subservice_cubit.dart';
import '../../../cubit/workerlist_cubit.dart';
import '../../../data/repository/search_repo.dart';
import '../../components/shimmer_circle_small.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SearchRepo searchRepo = SearchRepo();

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
                  svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
                  onTap: () {
                    context.pushNamed(QuikRoutes.notificationName);
                    context.read<NotificationCubit>().getNotifications();
                  }),
              QuikSpacing.hS10(),
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.logoutSvg,
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              QuikSpacing.hS24(),
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
                      onChanged: (String searchString) {
                        if (searchString.isEmpty) {
                          context.read<SearchBloc>().add(const SearchCleared());
                        } else {
                          context
                              .read<SearchBloc>()
                              .add(SearchStarted(query: searchString));
                        }
                      },
                      hintText: "Search for services..",
                      onMicPressed: () {},
                      onSearch: (String query) {},
                      controller: TextEditingController()),
                  QuikSpacing.vS4(),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is SearchLoaded) {
                        return SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              final String service =
                                  state.results[index]['service'] ?? "";
                              final String subService =
                                  state.results[index]['subservice'] ?? "All";
                              final String tags =
                                  state.results[index]['tag'] ?? "";
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<SearchBloc>().add(
                                        const SearchCleared()); // Clear search
                                    //!! JANKY CODE, MAY BREAK, NEED TO USE BETTER LOGIC OR ENUMS
                                    if (subService == "") {
                                      context.pushNamed(
                                          QuikRoutes.homeDetailsName,
                                          pathParameters: {'service': service});
                                    } else {
                                      context.pushNamed(
                                          QuikRoutes.homeDetailsFromSearchName,
                                          pathParameters: {
                                            'service': service,
                                            'subService': subService
                                          });
                                    }
                                  },
                                  child: ListTile(
                                    leading: Text(tags,
                                        style: chatSubTitle.copyWith(
                                            color: secondary)),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(subService,
                                            style: chatSubTitle.copyWith(
                                                color: secondary)),
                                        const SizedBox(
                                          height: 24,
                                          child: VerticalDivider(
                                              color: textInputIconColor),
                                        ),
                                        Text(service,
                                            style: chatSubTitle.copyWith(
                                                color: secondary)),
                                      ],
                                    ),
                                    tileColor: textInputBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      // side: const BorderSide(
                                      //   color: primary,
                                      //   width: 1,
                                      // ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is SearchEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text("No results found",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

                  QuikSpacing.vS16(),
                  BlocBuilder<ClientBloc, ClientState>(
                    builder: (context, state) {
                      if(state is ClientLoaded){
return GestureDetector(
                        onTap: () {
                          context.pushNamed(QuikRoutes.mapName,
                              extra: state.client.location);
                        }
                        // onTap: () async {
                        //   context.read<WorkerBloc>().add(FetchInitiated());

                        //   bool serviceEnabled;
                        //   LocationPermission permissionGranted;

                        //   serviceEnabled =
                        //       await Geolocator.isLocationServiceEnabled();
                        //   if (!serviceEnabled) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content:
                        //             Text('Please enable location services'),
                        //       ),
                        //     );
                        //     return;
                        //   }

                        //   permissionGranted =
                        //       await Geolocator.checkPermission();
                        //   if (permissionGranted ==
                        //       LocationPermission.denied) {
                        //     permissionGranted =
                        //         await Geolocator.requestPermission();
                        //     if (permissionGranted !=
                        //             LocationPermission.always &&
                        //         permissionGranted !=
                        //             LocationPermission.whileInUse) {
                        //       if (context.mounted) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           const SnackBar(
                        //             content: Text(
                        //                 'Location permission is denied'),
                        //           ),
                        //         );
                        //       }
                        //       return;
                        //     }
                        //   }

                        //   Position position =
                        //       await Geolocator.getCurrentPosition(
                        //           desiredAccuracy: LocationAccuracy.high);
                        //   context.read<WorkerBloc>().add(UpdateLocation(
                        //       LocationModel(
                        //           latitude: position.latitude,
                        //           longitude: position.longitude)));
                        // },
                        ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              QuikAssetConstants.locationFilledSvg,
                              color: primary,
                            ),
                            Text(
                              state.client.locationName ?? "Location",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.dropDownArrowSvg,
                                height: 18,
                                width: 18,
                                onTap: () {}),
                          ],
                        ),
                      );
                      }
                      else {
                        return const SizedBox();
                      }
                    },
                  )
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
                QuikSpacing.vS16(),
                Container(
                  width: 40,
                  height: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: QuikSpacing.vS30(),
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
            child: QuikSpacing.vS24(),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: BlocBuilder<ServicesBloc, ServicesState>(
              builder: (context, state) {
                if (state is ServicesLoaded) {
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
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<SubserviceCubit>()
                              .fetchSubservices(state.services[index].id);
                          context.read<WorkerlistCubit>().getWorkersByServiceId(
                              serviceId: state.services[index].id);
                          context.pushNamed(
                            QuikRoutes.homeDetailsName,
                            extra: state.services[index],
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: gridItemBackgroundColor),
                              alignment: Alignment.center,
                              height: 64,
                              width: 64,
                              child: SvgPicture.network(
                                state.services[index].avatar,
                                height: 24,
                                placeholderBuilder: (BuildContext context) =>
                                    Shimmer.fromColors(
                                        baseColor: gridItemBackgroundColor,
                                        highlightColor: Colors.grey[100]!,
                                        child: shimmerCard()),
                              ),
                            ),
                            QuikSpacing.vS8(),
                            Text(
                              state.services[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge,
                            )
                          ],
                        ),
                      );
                    }, childCount: state.services.length),
                  );
                } else if (state is ServicesLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is ServicesError) {
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
            child: QuikSpacing.vS48(),
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
            child: QuikSpacing.vS24(),
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
                            QuikAssetConstants.cleaningSvg,
                            height: 24,
                          )),
                      QuikSpacing.vS8(),
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
                      QuikSpacing.vS8(),
                      Text(
                        "Henry Kal",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      QuikSpacing.vS4(),
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
                            QuikAssetConstants.lawnMangementSvg,
                            height: 24,
                          )),
                      QuikSpacing.vS8(),
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
            child: QuikSpacing.vS48(),
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
            child: QuikSpacing.vS24(),
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
                        return const Placeholder();
                        // Column(
                        //   children: [
                        //     Container(
                        //       decoration: const BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color: gridItemBackgroundColor,
                        //       ),
                        //       alignment: Alignment.center,
                        //       height: 64,
                        //       width: 64,
                        //       child: Stack(
                        //         children: [
                        //           Positioned.fill(
                        //             child: ClipOval(
                        //               child: Image.asset(
                        //                 state.workers[index].profileImageUrl,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ),
                        //           if (state.workers[index].isVerified)
                        //             Positioned(
                        //               top: 0,
                        //               right: 0,
                        //               child: SvgPicture.asset(
                        //                 AppAssetLinks.verifiedBlueSvg,
                        //               ),
                        //             ),
                        //           Positioned(
                        //             bottom: 0,
                        //             left: 0,
                        //             child: RatingStar(
                        //                 rating: state.workers[index].rating
                        //                     .toString()),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     AppSizing.vS8(),
                        //     Text(
                        //       state.workers[index].name,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: Theme.of(context).textTheme.labelLarge,
                        //     ),
                        //     AppSizing.vS4(),
                        //     Text(
                        //       state.workers[index].category,
                        //       // overflow: TextOverflow.ellipsis,
                        //       style: Theme.of(context).textTheme.labelSmall,
                        //     )
                        //   ],
                        // );
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
