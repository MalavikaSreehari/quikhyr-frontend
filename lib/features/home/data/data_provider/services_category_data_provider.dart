import 'package:http/http.dart' as http;
import '../../../../common/constants/quik_secure_constants.dart';

class ServicesCategoryProvider {
  Future<String> getServicesData() async {
    try {
      final url = Uri.parse('$baseUrl/services');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final servicesCategory = response.body;
        return servicesCategory;
      } else {
        throw Exception('Failed to load services category');
      }
    } catch (e) {
      throw Exception('Failed to get services data: $e');
    }
  }
}
