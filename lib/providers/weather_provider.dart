import 'package:flutter/material.dart';

import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  List? _temperature;
  bool _isLoading = false;

  List? get temperature => _temperature;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(double lat, double lon) async {
    _isLoading = true;
    notifyListeners();

    final temp = await _weatherService.getCurrentTemperature(lat, lon);
    _temperature = temp;

    _isLoading = false;
    notifyListeners();
  }
}
