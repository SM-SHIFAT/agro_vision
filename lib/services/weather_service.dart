import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = dotenv.env['API_KEY'] ?? ''; // Replace with your key

  Future<List?> getCurrentTemperature(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final temp = data['main']['temp'];
      final wind = data['wind']['speed'];
      final city = data['name'];
      final weather_icon = data['weather'][0]['icon'];

      return [
        temp.toDouble(),
        wind.toDouble(),
        city.toString(),
        weather_icon.toString(),
      ];
    } else {
      print('Failed to load weather data: ${response.statusCode}');
      return null;
    }
  }
}
