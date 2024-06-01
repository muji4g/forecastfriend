import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forecastfriend/utils/colors.dart';
import 'package:forecastfriend/utils/text_styles.dart';
import 'package:intl/intl.dart';

class WeatherInfoBox extends StatelessWidget {
  final String imageString;
  final String text;
  const WeatherInfoBox(
      {super.key, required this.imageString, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: size.width * 1,
          decoration: BoxDecoration(color: secondaryColor.withOpacity(0.3)),
          child: Padding(
            padding: EdgeInsets.all(9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  imageString,
                  scale: 14,
                ),
                Text(
                  text,
                  style: regularText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
