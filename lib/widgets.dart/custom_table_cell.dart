import 'package:flutter/material.dart';
import 'package:spark/model/task_model.dart';
import 'package:spark/utils/cell_color_utills.dart';

Widget customTableCell(
  double height,
  String value,
  Coordinates currentPosition,
  Coordinates startPosition,
  Coordinates endPosition,
  List<Coordinates> steps,
) {
  final bool isBlocked = value == 'X';
  final Color cellColor =
      getColor(steps, currentPosition, startPosition, endPosition, isBlocked);
  final String positionText = '(${currentPosition.x},${currentPosition.y})';
  return Container(
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: Colors.black, width: 2),
    ),
    height: height,
    child: Center(
      child: Text(
        positionText,
        style: TextStyle(color: isBlocked ? Colors.white : null),
      ),
    ),
  );
}
