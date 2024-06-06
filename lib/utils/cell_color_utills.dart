import 'package:flutter/material.dart';
import 'package:spark/constants/color_constants.dart';
import 'package:spark/model/task_model.dart';

Color getColor(
  List<Coordinates> steps,
  Coordinates currentPosition,
  Coordinates startPosition,
  Coordinates endPosition,
  bool isBlocked,
) {
  if (isBlocked) {
    return ColorConstants.blockedCell;
  } else if (currentPosition == endPosition) {
    return ColorConstants.endPositionCell;
  } else if (currentPosition == startPosition) {
    return ColorConstants.startPositionCell;
  } else if (steps.contains(currentPosition)) {
    return ColorConstants.stepCell;
  } else {
    return ColorConstants.emptyCell;
  }
}
