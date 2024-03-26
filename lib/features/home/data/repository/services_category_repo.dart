// import 'package:quikhyr/features/home/data/data_provider/services_category_data_provider.dart';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:quikhyr/features/home/data/data_provider/services_category_data_provider.dart';
import 'package:quikhyr/models/service_category_model.dart';

class ServicesRepo {
  final ServicesCategoryProvider _servicesSource;

  ServicesRepo(this._servicesSource);

  Future<Either<String, List<ServiceModel>>> getServices() async {
      try {
    final servicesString = await _servicesSource.getServicesData();
    final servicesList = jsonDecode(servicesString) as List;
    final services = servicesList.map((serviceMap) {
      return ServiceModel.fromMap(serviceMap as Map<String, dynamic>);
    }).toList();

    return Right(services);
  } catch (error) {
    return Left((error.toString()));
  }

    // return [
    //   const ServiceModel(
    //     image: QuikAssetConstants.placeholderImage,
    //      avatar: 'assets/icons/plumbing.svg', description: 'Dummy Description',
    //     id: '1',
    //     name: 'Plumbing',
    //   ),
    //   const ServiceModel(
    //     image: QuikAssetConstants.placeholderImage,
    //     description: 'Dummy Description',
    //     id: '2',
    //     name: 'Auto Repair',
    //     avatar: 'assets/icons/auto_repair.svg',
    //   ),
    //   const ServiceModel(
    //     image: QuikAssetConstants.placeholderImage,
    //     description: 'Dummy Description',
    //     id: '2',
    //     name: 'Auto Repair',
    //     avatar: 'assets/icons/auto_repair.svg',
    //   ),
    // ];
  }
}
