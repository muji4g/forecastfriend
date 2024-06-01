import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forecastfriend/utils/colors.dart';
import 'package:forecastfriend/utils/text_styles.dart';
import 'package:forecastfriend/viewmodel/weatherapi_viewmodel.dart';
import 'package:forecastfriend/views/forecastpage/widgets/forecast_container.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ForeCastScreen extends StatefulWidget {
  final String? region;
  const ForeCastScreen({
    super.key,
    this.region,
  });

  @override
  State<ForeCastScreen> createState() => _ForeCastScreenState();
}

class _ForeCastScreenState extends State<ForeCastScreen> {
  WeatherViewModel? weather = WeatherViewModel();
  int days = 7;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'FORECAST',
            style: boldText,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: secondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: backgroundColor),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: weather!.fetchweather(widget.region.toString(), days),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset('assets/images/weather_loading.json'),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/images/error.json'),
                        Text(
                          snapshot.error.toString(),
                          style: boldText,
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.forecast == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/images/error.json', width: 120),
                        Text(
                          snapshot.error.toString(),
                          style: boldText,
                        ),
                      ],
                    ),
                  );
                } else {
                  var forecastData = snapshot.data!.forecast!.forecastday;
                  var today = DateFormat('yyyy-MM-dd').format(DateTime.now());
                  var upcomingForecasts = forecastData!.where((forecast) {
                    return forecast.date != today;
                  }).toList();

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: upcomingForecasts.length,
                    itemBuilder: (context, index) {
                      var forecast = upcomingForecasts[index];
                      final data = upcomingForecasts[index];

                      return Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              ForecastContainer(
                                img: Image.asset(
                                  'assets/images/calendar.png',
                                  scale: 14,
                                ),
                                apiData: '${forecast.date}',
                              ),
                              ForecastContainer(
                                img: Image.asset(
                                  'assets/images/high-temperature.png',
                                  scale: 14,
                                ),
                                apiData: '${data.day!.maxtempC}°C',
                              ),
                              ForecastContainer(
                                img: Image.asset(
                                  'assets/images/low-temperature.png',
                                  scale: 14,
                                ),
                                apiData: '${data.day!.mintempC}°C',
                              ),
                              ForecastContainer(
                                img: Image.asset(
                                  'assets/images/precipitation.png',
                                  scale: 14,
                                ),
                                apiData: data.day!.totalprecipMm.toString(),
                              ),
                              ForecastContainer(
                                img: Image.asset(
                                  'assets/images/rain-chance.png',
                                  scale: 14,
                                ),
                                apiData: data.day!.dailyChanceOfRain.toString(),
                              ),
                              ForecastContainer(
                                img: data.day!.condition!.text == "Sunny"
                                    ? Image.asset(
                                        'assets/images/sunny.png',
                                        scale: 14,
                                      )
                                    : data.day!.condition!.text ==
                                            "Partly cloudy"
                                        ? Image.asset(
                                            'assets/images/cloudy.png',
                                            scale: 14,
                                          )
                                        : data.day!.condition!.text ==
                                                    "Light rain shower" &&
                                                snapshot.data!.current
                                                        ?.condition!.text ==
                                                    "Light rain"
                                            ? Image.asset(
                                                'assets/images/light-rain_day.png',
                                                scale: 14,
                                              )
                                            : data.day!.condition!.text ==
                                                    "Mist"
                                                ? Image.asset(
                                                    'assets/images/mistday.png',
                                                    scale: 14,
                                                  )
                                                : data.day!.condition!.text ==
                                                        "Moderate rain"
                                                    ? Image.asset(
                                                        'assets/images/moderate_rain.png',
                                                        scale: 14,
                                                      )
                                                    : data.day!.condition!
                                                                .text ==
                                                            "Overcast"
                                                        ? Image.asset(
                                                            'assets/images/overcast.png',
                                                            scale: 14,
                                                          )
                                                        : data.day!.condition!
                                                                    .text ==
                                                                "Moderate or heavy snow showers"
                                                            ? Image.asset(
                                                                'assets/images/snowfall-heavy.png',
                                                                scale: 14,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/heavy-rain.png',
                                                                scale: 14,
                                                              ),
                                apiData: data.day!.condition!.text.toString(),
                              ),
                              ForecastContainer(
                                  img: Image.asset(
                                    'assets/images/sunrise.png',
                                    scale: 14,
                                  ),
                                  apiData: data.astro!.sunrise.toString()),
                              ForecastContainer(
                                  img: Image.asset(
                                    'assets/images/sunset.png',
                                    scale: 14,
                                  ),
                                  apiData: data.astro!.sunset.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
