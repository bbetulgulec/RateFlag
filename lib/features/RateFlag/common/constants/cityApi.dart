import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> searchCities(String query) async {
  final url = Uri.parse('https://turkiyeapi.dev/api/v1/provinces?name=$query');

  final res = await http.get(url);

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    return data['data'];
  } else {
    return [];
  }
}
