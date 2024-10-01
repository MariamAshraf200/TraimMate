import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherRemoteDataSource {
  final String apiKey = '1f377cc88e6c4b55910191125242909';
  final String baseUrl = 'http://api.weatherapi.com/v1/forecast.json';

  Future<Map<String, dynamic>> getWeatherData(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$baseUrl?key=$apiKey&q=$lat,$lon&days=7'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
