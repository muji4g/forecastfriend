import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forecastfriend/utils/colors.dart';
import 'package:forecastfriend/utils/text_constants.dart';
import 'package:forecastfriend/utils/text_styles.dart';
import 'package:forecastfriend/viewmodel/weatherapi_viewmodel.dart';
import 'package:forecastfriend/views/forecastpage/forecast_page.dart';
import 'package:forecastfriend/views/homepage/widgets/forecase_components.dart';
import 'package:forecastfriend/views/homepage/widgets/moreinfo_components.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _formatElapsedTime(DateTime lastUpdated) {
    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    if (difference.inMinutes < 1) {
      return 'Updated just now';
    } else if (difference.inMinutes < 60) {
      return 'Updated ${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return 'Updated ${difference.inHours} hours ago';
    } else {
      return 'Updated ${difference.inDays} days ago';
    }
  }

  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildElapsedTimeText(String lastUpdatedString) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final DateTime lastUpdated = formatter.parse(lastUpdatedString);
    final elapsedTimeText = _formatElapsedTime(lastUpdated);

    return Text(
      elapsedTimeText,
      style: regularText.copyWith(fontSize: 12),
    );
  }

  WeatherViewModel? weather = WeatherViewModel();
  String region = 'Rawalpindi';
  int days = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(EvaIcons.search),
          color: secondaryColor,
          iconSize: 28,
          onPressed: () {},
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: backgroundColor,
          ),
          child: FutureBuilder(
            future: weather?.fetchweather(region, days),
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
                ));
              } else if (!snapshot.hasData ||
                  snapshot.data!.forecast == null &&
                      snapshot.data!.forecast == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/images/error.json', width: 120),
                      Text(
                        snapshot.error.toString(),
                        style: boldText,
                      )
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04)
                      .copyWith(top: size.height * .12),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.012),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${snapshot.data!.location!.name.toString()}' +
                                  ' , ' +
                                  '${snapshot.data!.location!.country.toString()}',
                              style: regularText.copyWith(fontSize: 24),
                            ),
                            Container(
                              height: size.width * 0.09,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: secondaryColor, width: 1)),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  EvaIcons.plus,
                                  color: secondaryColor,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: size.width * 0.53,
                        ),
                        child: _buildElapsedTimeText(
                            snapshot.data!.current!.lastUpdated.toString()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          snapshot.data!.current?.condition!.text == "Sunny" &&
                                  snapshot.data!.current!.isDay == 1
                              ? Image.asset(
                                  'assets/images/sunny.png',
                                  width: size.width * 0.5,
                                  height: size.height * 0.3,
                                )
                              : snapshot.data!.current?.condition!.text == "Clear" &&
                                      snapshot.data!.current!.isDay == 0
                                  ? Image.asset(
                                      'assets/images/moon.png',
                                      width: size.width * 0.5,
                                      height: size.height * 0.3,
                                    )
                                  : snapshot.data!.current?.condition!.text ==
                                          "Partly cloudy"
                                      ? Image.asset(
                                          'assets/images/cloudy.png',
                                          width: size.width * 0.5,
                                          height: size.height * 0.3,
                                        )
                                      : snapshot.data!.current?.condition!.text ==
                                                  "Light rain shower" &&
                                              snapshot.data!.current?.condition!.text ==
                                                  "Light rain" &&
                                              snapshot.data!.current!.isDay == 1
                                          ? Image.asset(
                                              'assets/images/light-rain_day.png',
                                              width: size.width * 0.5,
                                              height: size.height * 0.3,
                                            )
                                          : snapshot.data!.current?.condition!.text ==
                                                      "Light rain shower" &&
                                                  snapshot.data!.current?.condition!.text ==
                                                      "Light rain" &&
                                                  snapshot.data!.current!.isDay ==
                                                      0
                                              ? Image.asset(
                                                  'assets/images/light-rain_night.png',
                                                  width: size.width * 0.5,
                                                  height: size.height * 0.3,
                                                )
                                              : snapshot.data!.current?.condition!.text == "Mist" &&
                                                      snapshot.data!.current!.isDay ==
                                                          1
                                                  ? Image.asset(
                                                      'assets/images/mistday.png',
                                                      width: size.width * 0.5,
                                                      height: size.height * 0.3,
                                                    )
                                                  : snapshot.data!.current?.condition!.text == "Mist" &&
                                                          snapshot.data!.current!.isDay ==
                                                              0
                                                      ? Image.asset(
                                                          'assets/images/mistnight.png',
                                                          width:
                                                              size.width * 0.5,
                                                          height:
                                                              size.height * 0.3,
                                                        )
                                                      : snapshot
                                                                  .data!
                                                                  .current
                                                                  ?.condition!
                                                                  .text ==
                                                              "Moderate rain"
                                                          ? Image.asset(
                                                              'assets/images/moderate_rain.png',
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              height:
                                                                  size.height *
                                                                      0.3,
                                                            )
                                                          : snapshot
                                                                      .data!
                                                                      .current
                                                                      ?.condition!
                                                                      .text ==
                                                                  "Overcast"
                                                              ? Image.asset(
                                                                  'assets/images/overcast.png',
                                                                  width:
                                                                      size.width *
                                                                          0.5,
                                                                  height:
                                                                      size.height *
                                                                          0.3,
                                                                )
                                                              : snapshot
                                                                          .data!
                                                                          .current
                                                                          ?.condition!
                                                                          .text ==
                                                                      "Moderate or heavy snow showers"
                                                                  ? Image.asset(
                                                                      'assets/images/snowfall-heavy.png',
                                                                      width: size
                                                                              .width *
                                                                          0.5,
                                                                      height:
                                                                          size.height *
                                                                              0.3,
                                                                    )
                                                                  : Image.asset(
                                                                      'assets/images/heavy-rain.png',
                                                                      width: size
                                                                              .width *
                                                                          0.4,
                                                                      height: size
                                                                              .height *
                                                                          0.25,
                                                                    ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.02),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.current!.tempC!
                                            .toStringAsFixed(0),
                                        style: boldText.copyWith(
                                            fontSize: snapshot
                                                        .data!.current!.tempC!
                                                        .toStringAsFixed(0)
                                                        .length >=
                                                    3
                                                ? size.width * 0.2
                                                : size.width * 0.25),
                                      ),
                                      // Add some spacing
                                      Text(
                                        'C',
                                        style: semiBoldText.copyWith(
                                            fontSize: size.width * 0.08),
                                      ),
                                    ],
                                  ),
                                  // Add spacing between rows
                                  Text(
                                    '${snapshot.data!.current?.condition!.text == "Sunny" && snapshot.data!.current!.isDay == 1 ? 'Sunny' : snapshot.data!.current?.condition!.text == "Clear" ? "Clear" : snapshot.data!.current?.condition!.text == "Partly cloudy" ? "Partly Cloudy" : snapshot.data!.current?.condition!.text == "Light rain shower" ? "Light rain shower" : snapshot.data!.current?.condition!.text == "Mist" ? "Mist" : snapshot.data!.current?.condition!.text == "Moderate rain" ? "Moderate rain" : snapshot.data!.current?.condition!.text == "Overcast" ? "Overcast" : snapshot.data!.current?.condition!.text == "Moderate or heavy snow showers" ? "Moderate or heavy snow " : snapshot.data!.current?.condition!.text == "Moderate or heavy rain" ? "Moderate or heavy rainfall" : "Patchy rain nearby"}',
                                    style: semiBoldText.copyWith(
                                        fontSize: size.width * 0.05),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      WeatherInfoBox(
                          imageString: 'assets/images/cloudy.png',
                          text: snapshot.data!.current!.cloud! > 0 ||
                                  snapshot.data!.current!.cloud! <= 50 ||
                                  snapshot.data!.current!.cloud! > 50
                              ? 'Cloudy'
                              : 'No Clouds'),
                      WeatherInfoBox(
                        imageString: 'assets/images/wind.png',
                        text: snapshot.data!.current!.windKph.toString() +
                            ' km/h',
                      ),
                      WeatherInfoBox(
                        imageString: 'assets/images/precipitation.png',
                        text:
                            snapshot.data!.current!.precipMm.toString() + ' mm',
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Forecast',
                            style:
                                boldText.copyWith(fontSize: size.width * 0.04),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForeCastScreen(
                                              region: region,
                                            )));
                              },
                              child: Text('See 7 day Forcast',
                                  style: boldText.copyWith(
                                      fontSize: size.width * 0.04)))
                        ],
                      ),
                      Container(
                        height: size.height * 0.15,
                        child: ListView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount:
                              snapshot.data!.forecast!.forecastday!.length,

                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final data =
                                snapshot.data!.forecast!.forecastday![index];
                            return ForecastComponents(
                              infoType: 'Date',
                              info: data.date.toString(),
                              secondinfoType: 'Max TEMP',
                              thirdinfoType: 'Min Temp',
                              secondinfo:
                                  data.day!.mintempC!.toStringAsFixed(0),
                              thirdinfo: data.day!.maxtempC!.toStringAsFixed(0),
                              fourthinfo: data.day!.dailyChanceOfRain!
                                  .toStringAsFixed(0),
                              fourthinfoType: 'Chance of Rain in %',
                              conditioninfoType: 'Condition',
                              conditionInfo:
                                  data.day!.condition!.text.toString(),
                            );
                          }, // Ensure no padding around ListView
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
