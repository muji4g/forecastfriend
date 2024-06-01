import 'package:flutter/cupertino.dart';
import 'package:forecastfriend/utils/colors.dart';
import 'package:forecastfriend/utils/text_styles.dart';
import 'package:forecastfriend/viewmodel/weatherapi_viewmodel.dart';

class ForecastComponents extends StatelessWidget {
  final String info;
  final String secondinfo;
  final String thirdinfo;
  final String fourthinfo;
  final String conditionInfo;

  final String infoType;
  final String secondinfoType;
  final String thirdinfoType;
  final String fourthinfoType;
  final String conditioninfoType;

  const ForecastComponents(
      {super.key,
      required this.info,
      required this.infoType,
      required this.secondinfoType,
      required this.thirdinfoType,
      required this.secondinfo,
      required this.thirdinfo,
      required this.fourthinfo,
      required this.fourthinfoType,
      required this.conditioninfoType,
      required this.conditionInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            InfoRow(infotype: infoType, info: info),
            InfoRow(infotype: secondinfoType, info: secondinfo),
            InfoRow(infotype: thirdinfoType, info: thirdinfo),
            InfoRow(infotype: fourthinfoType, info: fourthinfo),
            InfoRow(infotype: conditioninfoType, info: conditionInfo),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String infotype;
  final String info;
  const InfoRow({super.key, required this.infotype, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          infotype,
          style: regularText,
        ),
        Text(
          info,
          style: regularText,
        )
      ],
    );
  }
}
