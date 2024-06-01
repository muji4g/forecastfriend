import 'package:flutter/cupertino.dart';
import 'package:forecastfriend/utils/text_styles.dart';

class ForecastContainer extends StatelessWidget {
  final Image img;
  final String apiData;

  const ForecastContainer({
    super.key,
    required this.img,
    required this.apiData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: DataRow(img: img, apiData: apiData),
    );
  }
}

class DataRow extends StatelessWidget {
  final Image img;
  final String apiData;
  const DataRow({super.key, required this.img, required this.apiData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        img,
        Text(
          apiData,
          style: regularText,
        )
      ],
    );
  }
}
