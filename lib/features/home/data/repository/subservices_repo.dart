// import 'package:quikhyr/features/home/data/data_provider/services_category_data_provider.dart';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:quikhyr/features/home/data/data_provider/subservices_data_provider.dart';
import 'package:quikhyr/models/sub_service_category_model.dart';

class SubservicesRepo {
  final SubservicesCategoryProvider _servicesSource;

  SubservicesRepo(this._servicesSource);

  Future<Either<String, List<SubserviceModel>>> getServices(
      String serviceId) async {
    try {
      final subserviceString =
          await _servicesSource.getSubservicesData(serviceId);
      final subservicesList = jsonDecode(subserviceString) as List;
      final subservices = subservicesList.map((serviceMap) {
        return SubserviceModel.fromMap(serviceMap as Map<String, dynamic>);
      }).toList();

      return Right(subservices);
    } catch (error) {
      return Left((error.toString()));
    }
  }
}
