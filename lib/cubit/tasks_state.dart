part of 'tasks_cubit.dart';

class TasksState {
  List<Task> tasksList;
  String? error;
  Task selectedTask;
  String link;
  bool isLoading;
  double loadingProcess;

  TasksState copyWith({
    List<Task>? tasksList,
    String? error,
    Task? selectedTask,
    bool? isSolved,
    String? link,
    bool? isLoading,
    double? loadingProcess,
  }) {
    return TasksState(
      tasksList: tasksList ?? this.tasksList,
      error: error ?? this.error,
      selectedTask: selectedTask ?? this.selectedTask,
      link: link ?? this.link,
      isLoading: isLoading ?? this.isLoading,
      loadingProcess: loadingProcess ?? this.loadingProcess,
    );
  }

  TasksState({
    required this.tasksList,
    required this.selectedTask,
    required this.link,
    required this.isLoading,
    required this.loadingProcess,
    this.error,
  });
}

class InitialTaskState extends Task {
  InitialTaskState()
      : super(
          id: 'empty',
          field: [],
          start: Coordinates(0, 0),
          end: Coordinates(2, 2),
          steps: [],
        );
}

class InitialTaskstate extends TasksState {
  InitialTaskstate()
      : super(
          tasksList: [],
          selectedTask: InitialTaskState(),
          link: TaskApiClient.baseUrl,
          isLoading: false,
          loadingProcess: 0,
        );
}
