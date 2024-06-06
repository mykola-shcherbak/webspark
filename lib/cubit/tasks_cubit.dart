import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/api/task_api.dart';
import 'package:spark/model/task_model.dart';
import 'package:spark/repository/task_repository.dart';
import 'package:spark/utils/task_solution_utills.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({required this.repository}) : super(InitialTaskstate());

  final TaskRepository repository;

  Future<void> getTasks(String link) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<Task> tasks = await repository.getTasks(link);
      emit(state.copyWith(isLoading: false));
      final List<Task> solvedTasks = processTasks(tasks);

      emit(state.copyWith(tasksList: solvedTasks, link: link));
    } catch (e) {
      print(e);
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> selectTask(Task task) async {
    emit(state.copyWith(selectedTask: task));
  }

  Future<void> postSolution() async {
    emit(state.copyWith(isLoading: true));
    try {
      await repository.postSolution(state.tasksList);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
      rethrow;
    }
  }

  List<Task> processTasks(List<Task> tasksList) {
    List<Task> solvedtasks = [];

    for (int i = 0; i < tasksList.length; i++) {
      Task solvedtask = solveTask(tasksList[i]);
      double loadingProcess = (i + 1) / tasksList.length;
      emit(state.copyWith(loadingProcess: loadingProcess));
      solvedtasks.add(solvedtask);
    }
    return solvedtasks;
  }
}
