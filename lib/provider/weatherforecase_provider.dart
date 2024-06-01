// import 'package:flutter/material.dart';
// import 'package:forecastfriend/model/weatherforcast.dart';
// import 'package:forecastfriend/services/weatherapi_service.dart';

// class WeatherProvider with ChangeNotifier {
//   WeatherApiService _weatherservice = WeatherApiService();
//   bool _isLoading = false;
//   String? _error;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   WeatherForCastModel? _weather;

//   WeatherForCastModel? get weather => _weather;

//   Future<void> fetchweather(String query) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _weather = await _weatherservice.fetchWeather('Rawalpindi');
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
