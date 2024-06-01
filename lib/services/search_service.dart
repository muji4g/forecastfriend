import 'dart:convert';

import 'package:forecastfriend/model/weatherforcast.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<WeatherForCastModel> fetchSearchResult(String query) async {
    final url =
        'http://api.weatherapi.com/v1/forecast.json?key=77a270ea43e94c559af101857242605&q=$query&days=1&aqi=no&alerts=no';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForCastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed!');
    }
  }
}
