import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:quikhyr/models/overall_rating_model.dart';
import 'package:http/http.dart' as http;
import '../constants/quik_secure_constants.dart';

class FeedbackRepo {
  Future<Either<String, bool>> sendOverallFeedback(OverallRatingModel overallRatingModel) async{
 try {
      final url = Uri.parse('$baseUrl/ratings');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: overallRatingModel.toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        log(response.body);
        return Left('Failed to create notification ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create notification $e');
    }
  }
}