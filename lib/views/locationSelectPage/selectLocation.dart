import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forecastfriend/model/weatherforcast.dart';
import 'package:forecastfriend/utils/colors.dart';
import 'package:forecastfriend/utils/text_styles.dart';
import 'package:forecastfriend/viewmodel/searchapi_viewmodel.dart';
import 'package:forecastfriend/views/homepage/homepage.dart';
import 'package:lottie/lottie.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController searchController = TextEditingController();
  SearchViewModel selectLocation = SearchViewModel();
  Future<WeatherForCastModel>? searchFuture;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? region;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          decoration: BoxDecoration(gradient: backgroundColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04)
                .copyWith(top: size.height * 0.1),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  style: regularText,
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    fillColor: secondaryColor.withOpacity(0.2),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      color: secondaryColor,
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                        });
                      },
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: secondaryColor,
                    ),
                    label: Text(
                      'Search For cities',
                      style: regularText,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: secondaryColor, width: 1.2),
                        borderRadius: BorderRadius.circular(14)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: secondaryColor, width: 1.2),
                        borderRadius: BorderRadius.circular(14)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: secondaryColor, width: 1.2),
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      region = searchController.text;
                      searchFuture = selectLocation.fetchSearchResult(value);
                    });
                  },
                ),
                Expanded(
                  child: FutureBuilder<WeatherForCastModel>(
                    future: searchFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Lottie.asset(
                                'assets/images/weather_loading.json'));
                      } else if (snapshot.hasError) {
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
                          snapshot.data == null ||
                          searchController.text.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seach for a region',
                                style: boldText,
                              )
                            ],
                          ),
                        );
                      } else {
                        region = searchController.text;
                        final data = snapshot.data!;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            location: region.toString(),
                                          )));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                  bottom: size.height * 0.65),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: secondaryColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tap to View Details',
                                          style: regularText,
                                        ),
                                        ListTile(
                                          title: Text(
                                            '${data.location!.name}' +
                                                ' , ' +
                                                ''
                                                    '${data.location!.country}'
                                                    '',
                                            style: regularText,
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${data.current!.condition!.text}',
                                                style: regularText,
                                              ),
                                              Text(
                                                data.current!.tempC!
                                                        .toStringAsFixed(0) +
                                                    '\u2103',
                                                style: regularText,
                                              )
                                            ],
                                          ),
                                        ),
                                      ])),
                            ));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
