import 'package:flutter/material.dart';
import 'package:spark/constants/color_constants.dart';
import 'package:spark/constants/text_constants.dart';

Widget loader() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(TextConstants.loading),
        const SizedBox(height: 50),
        CircularProgressIndicator(
          color: ColorConstants.accentColor,
        ),
      ],
    ),
  );
}
