import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecastfriend/utils/colors.dart';
import 'package:forecastfriend/utils/text_styles.dart';
import 'package:forecastfriend/viewmodel/searchapi_viewmodel.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  SearchViewModel searchView = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.search),
          color: secondaryColor,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundColor),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04)
              .copyWith(top: size.height * 0.15),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                style: regularText,
                cursorColor: secondaryColor,
                decoration: InputDecoration(
                  fillColor: secondaryColor.withOpacity(0.2),
                  prefixIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                  label: Text(
                    'Search For cities',
                    style: regularText,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(14)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(14)),
                ),
                onSubmitted: (value) {
                  setState(() {});
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: searchView.fetchSearchResult(searchController.text),
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
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/images/error.json',
                                width: 120),
                            Text(
                              'No data found',
                              style: boldText,
                            )
                          ],
                        ),
                      );
                    } else {
                      final data = snapshot.data!;
                      final query = data.location?.name ?? '';
                      if (query
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return ListTile(
                          title: Text('${data.location!.name}'),
                        );
                      } else {
                        return Center(
                          child: Text('NO SUCH COUNTRY FOUND'),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
