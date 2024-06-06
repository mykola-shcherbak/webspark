import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spark/cubit/tasks_cubit.dart';
import 'package:spark/constants/text_constants.dart';
import 'package:spark/model/task_model.dart';
import 'package:spark/screens/preview_screen.dart';
import 'package:spark/widgets.dart/custom_app_bar.dart';
import 'package:spark/widgets.dart/empty_result_item.dart';
import 'package:spark/widgets.dart/result_item.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  static String path = '/result_screen';
  static String route = 'result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, TextConstants.resultScreen, context.pop),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<TasksCubit, TasksState>(
              builder: (context, state) {
                final List<Task> tasksList = state.tasksList;
                return Expanded(
                  child: ListView.builder(
                      itemCount: max(tasksList.length, 20),
                      itemBuilder: (context, index) {
                        if (index >= tasksList.length) {
                          return emptyResultItem();
                        }

                        final String title = state.tasksList[index].path ?? '';
                        void onTap() {
                          final Task task = tasksList[index];
                          context.read<TasksCubit>().selectTask(task);
                          context.push(PreviewScreen.path);
                        }

                        return resultItem(title, onTap);
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
