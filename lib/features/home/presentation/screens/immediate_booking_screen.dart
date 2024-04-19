// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/bloc/client_bloc.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/long_icon_button.dart';
import 'package:quikhyr/common/widgets/quik_small_text_with_border.dart';
import 'package:quikhyr/features/auth/presentation/components/my_text_field.dart';
import 'package:quikhyr/features/chat/firebase_storage_service.dart';
import 'package:quikhyr/features/chat/media_service.dart';
import 'package:quikhyr/features/home/cubit/subservice_cubit.dart';
import 'package:quikhyr/features/home/cubit/workerlist_cubit.dart';
import 'package:quikhyr/features/home/presentation/components/quik_drop_down_button.dart';
import 'package:quikhyr/features/home/presentation/components/shimmer_circle_small.dart';
import 'package:quikhyr/features/notification/cubit/notification_cubit.dart';
import 'package:quikhyr/models/location_model.dart';
import 'package:quikhyr/models/notification_model.dart';
import 'package:quikhyr/models/service_category_model.dart';
import 'package:quikhyr/models/sub_service_category_model.dart';
import 'package:shimmer/shimmer.dart';

class ImmediateBookingScreen extends StatefulWidget {
  final SubserviceModel? subserviceModel;
  const ImmediateBookingScreen({
    Key? key,
    required this.subserviceModel,
  }) : super(key: key);

  @override
  State<ImmediateBookingScreen> createState() => _ImmediateBookingScreenState();
}

class _ImmediateBookingScreenState extends State<ImmediateBookingScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  SubserviceModel _selectedSubservice = SubserviceModel(
      id: "0",
      serviceId: "0",
      serviceName: "All",
      name: "All Subservices",
      description: "All",
      tags: const []);
  String _imageUrl = QuikAssetConstants.placeholderImage;
  LocationModel _locationModel = LocationModel(
    latitude: 0.0,
    longitude: 0.0,
  );
  Future<void> handleImagePickingAndUploadingFromGallery() async {
    final image = await MediaService.pickImage();
    if (image != null) {
      //!! GIVE SUITABLE NAME TO STORAGE SERVICE
      _imageUrl =
          await FirebaseStorageService.uploadImage(image, '${DateTime.now()}');
      setState(() {});
    }
  }

  Future<void> handleImagePickingAndUploadingFromCamera() async {
    final image = await MediaService.pickImageFromCamera();
    if (image != null) {
      //!! GIVE SUITABLE NAME TO STORAGE SERVICE
      _imageUrl =
          await FirebaseStorageService.uploadImage(image, '${DateTime.now()}');
      setState(() {});
    }
  }

  void _initLocation() async {
    // Use Future.delayed to ensure the context is available
    if (await Geolocator.isLocationServiceEnabled()) {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final permissionStatus = await Geolocator.requestPermission();
        if (permissionStatus == LocationPermission.denied) {
          // Handle denied permission
        } else if (permissionStatus == LocationPermission.deniedForever) {
          // Handle denied forever permission
        } else {
          // Permission granted, continue with location initialization
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          setState(() {
            _locationModel = LocationModel(
              latitude: position.latitude,
              longitude: position.longitude,
            );
          });
        }
      } else if (permission == LocationPermission.deniedForever) {
        // Handle denied forever permission
      } else {
        // Permission granted, continue with location initialization
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _locationModel = LocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
          );
        });
      }
    } else {
      // Location service is disabled, handle accordingly
    }
    Future.delayed(Duration.zero, () async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationModel = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      });
      if (context.mounted) {
        context.read<ClientBloc>().add(UpdateLocation(LocationModel(
            latitude: position.latitude, longitude: position.longitude)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
leading: Row(
                children: [
                  QuikSpacing.hS12(),
                  ClickableSvgIcon(
                    svgAsset: QuikAssetConstants.backArrowSvg,
                    size: 32,
                    onTap: () {
                      context.pop();
                    },
                  ),
                  QuikSpacing.hS12(),
                ],
              ),
              // titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: gridItemBackgroundColor),
                    alignment: Alignment.center,
                    height: 36,
                    width: 36,
                    // child: SvgPicture.network(
                    //   semanticsLabel: "Service Avatar",
                    //   QuikAssetConstants.serviceNotFoundImageSvg,
                    //   height: 24,
                    //   placeholderBuilder: (BuildContext context) =>
                    //       Shimmer.fromColors(
                    //           baseColor: gridItemBackgroundColor,
                    //           highlightColor: Colors.grey[100]!,
                    //           child: shimmerCard()),
                    // ),
                    //TODO : Add service image
                    child: SvgPicture.asset(
                      QuikAssetConstants.plumbingSvg,
                      height: 24,
                      placeholderBuilder: (BuildContext context) =>
                          Shimmer.fromColors(
                              baseColor: gridItemBackgroundColor,
                              highlightColor: Colors.grey[100]!,
                              child: shimmerCard()),
                    ),
                  ),
                  QuikSpacing.hS12(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subserviceModel?.serviceName ?? "Service Name",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      QuikSpacing.vS8(),
                      const Text("Service", style: chatSubTitle),
                    ],
                  )
                ],
              ),
              // actions: [
              //   SvgPicture.asset(QuikAssetConstants.availableCircleShadesSvg,
              //       semanticsLabel: "Service Avatar", height: 24, width: 24),
              //   QuikSpacing.hS4(),
              //   const Text("Available", style: availabilityTextStyle),
              //   QuikSpacing.hS24(),
              // ],
            ),
          ),
        ),

        // body: Center(child: Text(serviceModel.title)));
        body: SingleChildScrollView(
          child: BlocListener<NotificationCubit, NotificationState>(
            listener: (context, state) {
              if (state is NotificationSentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green),
                        SizedBox(width: 8),
                        Text("Service Request Signal Sent",
                            style: TextStyle(color: primary)),
                      ],
                    ),
                    backgroundColor: Colors.green[50],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              } else if (state is NotificationSentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.error_outline, color: secondary),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(state.error,
                                style: const TextStyle(color: secondary))),
                      ],
                    ),
                    backgroundColor: error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientSeparator(),
                  QuikSpacing.vS24(),
                  Text(
                    "IMMEDIATE BOOKING",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  QuikSpacing.vS24(),
                  const Text(
                    "Send a service request signal to the entire available workers network, so that you can get your service as fast as possible.",
                    style: descriptionTextStyle,
                  ),
                  QuikSpacing.vS32(),
                  BlocBuilder<SubserviceCubit, SubserviceState>(
                    builder: (context, state) {
                      if (state is SubservicesLoading) {
                        return const CircularProgressIndicator(); // Show loading indicator
                      } else if (state is SubservicesLoaded) {
                        return QuikDropDownButtonSubservice(
                          onSubserviceSelected: (subservice) {
                            context
                                .read<SubserviceCubit>()
                                .subserviceSelected(subservice);
                            _selectedSubservice = subservice;
                          },
                          subservices: state.subservices,
                        );
                      } else if (state is SubservicesError) {
                        return Text(state.message);
                      } else {
                        return const Text("Unknown Error");
                      }
                    },
                  ),
                  QuikSpacing.vS16(),

                  BlocBuilder<ClientBloc, ClientState>(
                    builder: (context, state) {
                      if (state is ClientLoaded) {
                        return MyTextField(
                          initialValue: state.client.locationName,
                          obscureText: false,
                          // controller: _addressController,
                          hintText: "Location",
                          keyboardType: TextInputType.streetAddress,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  QuikSpacing.vS16(),
                  MyTextField(
                    obscureText: false,
                    controller: _descriptionController,
                    hintText: "Brief Description",
                    keyboardType: TextInputType.text,
                  ),
                  QuikSpacing.vS16(),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add Work Location Image",
                      style: workerListNameTextStyle,
                    ),
                  ),
                  QuikSpacing.vS16(),

                  Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.network(
                        _imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  QuikSpacing.vS12(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            handleImagePickingAndUploadingFromGallery(),
                        child: const Text(
                          'Select from Gallery',
                          style: chatSubTitleRead,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            handleImagePickingAndUploadingFromCamera(),
                        child: const Text(
                          'Take a Photo',
                          style: chatSubTitleRead,
                        ),
                      ),
                    ],
                  ),
                  QuikSpacing.vS32(),
                  // Use BlocBuilder again to react to state changes for the button
                  BlocBuilder<SubserviceCubit, SubserviceState>(
                    builder: (context, state) {
                      // Determine if the button should be enabled based on the state
                      final isButtonEnabled = state is SubservicesLoaded &&
                          state.isSendServiceRequestSignalEnabled;
                      return LongIconButton(
                        text: "Worker Alert Signal",
                        onPressed: isButtonEnabled
                            ? () {
                                context
                                    .read<NotificationCubit>()
                                    .sendNotification(NotificationModel(
                                      senderId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      subserviceId: _selectedSubservice.id,
                                      description: _descriptionController.text,
                                      images: [_imageUrl],
                                      location: _locationModel,
                                    ));
                                debugPrint("Send Service Request Signal");
                              }
                            : null,
                        svgPath: QuikAssetConstants.sendSvg,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
