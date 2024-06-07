import 'package:flutter/foundation.dart';
import 'package:spark/model/task_model.dart';

Task solveTask(Task task) {
  final List<int> start = coorditateToList(task.start);
  final List<int> end = coorditateToList(task.end);

  final List<List<int>> freeCells = findFreeCells(task.field);

  List<int> currentPostion = [...start];
  final List<List<int>> steps = [start];

  void removeFromFreeCells(List<int> cell) {
    freeCells.removeWhere((e) => listEquals(e, cell));
  }

  bool checkIfCellIsFree(List<int> cell) {
    return freeCells.any((e) => listEquals(e, cell));
  }

  List<int> findNeighbor(List<int> current) {
    List<int> neighbor = freeCells.firstWhere((e) =>
        (current[0] >= e[0] - 1 && current[0] <= e[0] + 1) &&
        (current[1] >= e[1] - 1 && current[1] <= e[1] + 1) &&
        !listEquals(current, e));
    return neighbor;
  }

  List<int>? findFastestWay(List<int> current, List<int> direction) {
    List<int> stepXY = [current[0] + direction[0], current[1] + direction[1]];
    List<int> stepX = [current[0] + direction[0], direction[1]];
    List<int> stepY = [direction[0], current[1] + direction[1]];
    if (checkIfCellIsFree(stepXY)) {
      return stepXY;
    } else if (direction[0] != 0 && checkIfCellIsFree(stepX)) {
      return stepX;
    } else if (direction[1] != 0 && checkIfCellIsFree(stepY)) {
      return stepY;
    } else {
      List<int> neighbor = findNeighbor(current);
      removeFromFreeCells(current);
      return neighbor;
    }
  }

  int compare(int current, int end) {
    if (current < end) {
      return 1;
    } else if (current > end) {
      return -1;
    }
    return 0;
  }

  List<int> findDirectinon(List<int> current) {
    List<int> result = [0, 0];
    result[0] = compare(current[0], end[0]);
    result[1] = compare(current[1], end[1]);

    return result;
  }

  while (!listEquals(currentPostion, end)) {
    List<int> directinon = findDirectinon(currentPostion);
    List<int>? newStep = findFastestWay(currentPostion, directinon);

    if (newStep != null) {
      currentPostion = newStep;
      steps.add(newStep);
    }
  }

  final List<Coordinates> solvedSteps = stepsToCoordinates(steps);
  final String path = stepsToString(steps);

  return task.copyWith(steps: solvedSteps, path: path);
}

List<int> coorditateToList(Coordinates coordinate) {
  return [coordinate.x, coordinate.y];
}

List<List<int>> findFreeCells(List<String> field) {
  List<List<int>> freePath = [];

  for (int i = 0; i < field.length; i++) {
    for (int z = 0; z < field[i].length; z++) {
      if (field[i][z] == '.') {
        freePath.add(coorditateToList(Coordinates(z, i)));
      }
    }
  }
  return freePath;
}

List<Coordinates> stepsToCoordinates(List<List<int>> steps) {
  List<Coordinates> coordinates = [];

  for (int i = 0; i < steps.length; i++) {
    coordinates.add(Coordinates(steps[i][0], steps[i][1]));
  }
  return coordinates;
}

String stepsToString(List<List<int>> steps) {
  return steps.map((step) => '(${step[0]},${step[1]})').toList().join('=>');
}
