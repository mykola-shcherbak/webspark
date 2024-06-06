import 'package:flutter/material.dart';
import 'package:spark/constants/color_constants.dart';

OutlinedButton customButton(
    String title, VoidCallback onPress, bool isBlocked) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.maxFinite, 50),
      backgroundColor: isBlocked ? null : ColorConstants.accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    onPressed: isBlocked ? null : onPress,
    child: Text(
      title,
      style: TextStyle(color: ColorConstants.buttonTitile),
    ),
  );
}
