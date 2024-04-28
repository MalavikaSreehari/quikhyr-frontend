import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../models/worker_model.dart';
import '../constants/quik_secure_constants.dart';

class WorkerRepo {
  Future<Either<String, WorkerModel>> getWorker(
      {required String workerId}) async {
    final url = Uri.parse('$baseUrl/workers/$workerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Right(WorkerModel.fromJson(response.body));
    } else {
      return Left('Failed to get worker ${response.body}');
    }
  }
}
