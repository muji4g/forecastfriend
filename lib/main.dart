import 'package:flutter/material.dart';
import 'package:forecastfriend/provider/weatherforecase_provider.dart';
import 'package:forecastfriend/views/forecastpage/forecast_page.dart';
import 'package:forecastfriend/views/homepage/homepage.dart';
import 'package:forecastfriend/views/locationSelectPage/selectLocation.dart';
import 'package:forecastfriend/views/searchpage/search_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forecast Friend',
      home: const SelectLocation(),
      routes: {
        '/searchPage': (context) => const SearchScreen(),
      },
    );
  }
}
