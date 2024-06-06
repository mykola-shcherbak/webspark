import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spark/constants/color_constants.dart';
import 'package:spark/constants/text_constants.dart';

Widget customPercentIndicator(double percent, String? error) {
  final percentText = '${percent * 100} %';
  String geTitle() {
    if (error != null) {
      return error.toString();
    } else if (percent == 1) {
      return TextConstants.calculationsFinised;
    } else {
      return '';
    }
  }

  return CircularPercentIndicator(
    radius: 130.0,
    animation: error == null ? true : false,
    animateFromLastPercent: true,
    animationDuration: 600,
    lineWidth: 15.0,
    percent: percent,
    progressColor: ColorConstants.accentColor,
    header: Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Text(
              geTitle(),
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            percentText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    ),
  );
}
