import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:quikhyr/common/constants/quik_secure_constants.dart';
import 'package:quikhyr/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr/models/location_model.dart';

class ClientRepo {
  Future<Either<String, ClientModel>> getClient(
      {required String clientId}) async {
    final url = Uri.parse('$baseUrl/clients/$clientId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Right(ClientModel.fromJson(response.body));
    } else {
      return Left('Failed to get client ${response.body}');
    }
  }


  Future<Either<String, bool>> isUserCreatedInFirestore(String userId) async {
    try {
      final url = Uri.parse('$baseUrl/clients/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 404) {
        return const Right(false);
      } else {
        return const Left('Failed to check user existence in Firestore');
      }
    } catch (e) {
      return Left('Failed to check user existence in Firestore: $e');
    }
  }


  Future<Either<String, String>> updateClientPincode(
      {required String clientId, required String pincode}) async {
    try {
      final url = Uri.parse('$baseUrl/clients/$clientId');
      final body = jsonEncode({"pincode": pincode});
      final response = await http
          .put(url, body: body, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        return const Right('Client pincode updated');
      } else {
        return Left('Failed to update client pincode ${response.body}');
      }
    } catch (e) {
      return Left('Failed to update client pincode: $e');
    }
  }

Future<Either<String, String>> updateClientLocation(
    {required String clientId, required LocationModel location}) async {
  try {
    final url = Uri.parse('$baseUrl/clients/$clientId');
      final body = jsonEncode({'location': location.toMap()});
    final response = await http
        .put(url, body: body, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return const Right('Client location updated');
    } else {
      return Left('Failed to update worker location ${response.body}');
    }
  } catch (e) {
    return Left('Failed to update worker location: $e');
  }
}
}
