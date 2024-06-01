import 'dart:convert';

import 'package:forecastfriend/domains/api_domains.dart';
import 'package:forecastfriend/model/weatherforcast.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  Future<WeatherForCastModel> fetchWeather(String query, int days) async {
    final url =
        'http://api.weatherapi.com/v1/forecast.json?key=77a270ea43e94c559af101857242605&q=$query&days=$days&aqi=no&alerts=no';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForCastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed To load Weather!');
    }
  }
}
