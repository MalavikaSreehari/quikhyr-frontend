import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../data_provider/worker_list_data_provider.dart';
import '../../../../models/worker_model.dart';

class WorkerListRepo {
  final WorkerListDataProvider _workerListDataProvider;

  WorkerListRepo(this._workerListDataProvider);

  Future<Either<String, List<WorkerModel>>> getWorkersByServiceId(String serviceId) async {
    try {
      final workerListString = await _workerListDataProvider.getWorkersByServiceId(serviceId);
      final workerList = jsonDecode(workerListString) as List;
      final workers = workerList.map((workerMap) {
        return WorkerModel.fromMap(workerMap as Map<String, dynamic>);
      }).toList();

      return Right(workers);
    } catch (error) {
      return Left((error.toString()));
    }
  }
    Future<Either<String, List<WorkerModel>>> getWorkersBySubserviceId(String subserviceId) async {
    try {
      final workerListString = await _workerListDataProvider.getWorkersBySubserviceId(subserviceId);
      final workerList = jsonDecode(workerListString) as List;
      final workers = workerList.map((workerMap) {
        return WorkerModel.fromMap(workerMap as Map<String, dynamic>);
      }).toList();

      return Right(workers);
    } catch (error) {
      return Left((error.toString()));
    }
  }

}