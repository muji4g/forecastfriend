import 'package:forecastfriend/model/weatherforcast.dart';
import 'package:forecastfriend/services/weatherapi_service.dart';

class WeatherViewModel {
  final rep = WeatherApiService();
  Future<WeatherForCastModel> fetchweather(String region, int days) async {
    final response = await rep.fetchWeather(region, days);
    return response;
  }
}
