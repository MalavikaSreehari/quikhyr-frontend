import 'package:http/http.dart' as http;

class ServicesCategoryDataProvider {
  Future<String> getServicesCategory() async {
    //TODO: Replace with actual API
    final response = await http.get(Uri.parse('X'));
    if (response.statusCode == 200) {
      final servicesCategory = response.body;
      return servicesCategory;
    } else {
      throw Exception('Failed to load services category');
    }
  }
}
