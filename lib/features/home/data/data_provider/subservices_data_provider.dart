import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:quikhyr/common/constants/quik_secure_constants.dart';

class SubservicesCategoryProvider {
  Future<String> getSubservicesData(String serviceId) async {
    try {
      final url = Uri.parse('$baseUrl/subservices/?serviceId=$serviceId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final servicesCategory = response.body;
        log('$servicesCategory SubServicesCategoryList');
        return servicesCategory;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception('Failed to get services data: $e');
    }
  }
}
