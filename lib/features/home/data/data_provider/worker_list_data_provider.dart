import 'package:http/http.dart' as http;
import '../../../../common/constants/quik_secure_constants.dart';

class WorkerListDataProvider {
  Future<String> getWorkersByServiceId(String serviceId) async {
    try {
      final url = Uri.parse('$baseUrl/workers?serviceId=$serviceId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final workerList = response.body;
        return workerList;
      } else {
        throw Exception('Failed to load workers');
      }
    } catch (e) {
      throw Exception('Failed to get workers data: $e');
    }
  }
    Future<String> getWorkersBySubserviceId(String subserviceId) async {
    try {
      final url = Uri.parse('$baseUrl/workers?subserviceId=$subserviceId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final workerList = response.body;
        return workerList;
      } else {
        throw Exception('Failed to load workers');
      }
    } catch (e) {
      throw Exception('Failed to get workers data: $e');
    }
  }

}
