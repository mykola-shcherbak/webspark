import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/api/task_api.dart';
import 'package:spark/cubit/tasks_cubit.dart';
import 'package:spark/repository/task_repository.dart';
import 'package:spark/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository = TaskRepository(
    taskApiClient: TaskApiClient(),
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksCubit(repository: taskRepository),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
