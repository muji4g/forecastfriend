import 'package:forecastfriend/model/weatherforcast.dart';
import 'package:forecastfriend/services/search_service.dart';
import 'package:forecastfriend/services/weatherapi_service.dart';

class SearchViewModel {
  final rep = SearchService();
  Future<WeatherForCastModel> fetchSearchResult(String region) async {
    final response = await rep.fetchSearchResult(region);
    return response;
  }
}
