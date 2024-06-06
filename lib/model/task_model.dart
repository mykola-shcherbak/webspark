class Task {
  String id;
  List<String> field;
  Coordinates start;
  Coordinates end;
  List<Coordinates>? steps;
  String? path;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
    this.steps,
    this.path,
  });

  Task copyWith({
    String? id,
    List<String>? field,
    Coordinates? start,
    Coordinates? end,
    List<Coordinates>? steps,
    String? path,
  }) {
    return Task(
      id: id ?? this.id,
      field: field ?? this.field,
      start: start ?? this.start,
      end: end ?? this.end,
      steps: steps ?? this.steps,
      path: path ?? this.path,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        field: [...json['field']],
        start: Coordinates(
          json['start']['x'],
          json['start']['y'],
        ),
        end: Coordinates(
          json['end']['x'],
          json['end']['y'],
        ),
      );

  Map<String, dynamic> taskToSolutionMap() {
    final steps = coordinateToMap(this.steps ?? []);
    return {
      "id": id,
      "result": {"steps": steps, "path": path?.replaceAll('=', '-')}
    };
  }

  List<Map<String, String>> coordinateToMap(List<Coordinates> steps) {
    return steps
        .map((step) => {
              "x": "${step.x}",
              "y": "${step.y}",
            })
        .toList();
  }
}

class Coordinates {
  int x;
  int y;

  Coordinates(this.x, this.y);

  @override
  bool operator ==(covariant Coordinates other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
