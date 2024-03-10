import 'package:http/http.dart' as http;

class MostRatedWorkersDataProvider {}

Future<String> getMostRatedWorkers() async {
   //TODO: Replace with actual API
  final response = await http.get(Uri.parse('X'));
  if (response.statusCode == 200) {
    final mostRatedWorkers = response.body;
    return mostRatedWorkers;
  } else {
    throw Exception('Failed to load most rated workers');
  }
}
