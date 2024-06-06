import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spark/cubit/tasks_cubit.dart';
import 'package:spark/constants/text_constants.dart';
import 'package:spark/screens/result_screen.dart';
import 'package:spark/widgets.dart/custom_app_bar.dart';
import 'package:spark/widgets.dart/custom_button.dart';
import 'package:spark/widgets.dart/custom_percent_indicator.dart';
import 'package:spark/widgets.dart/loader.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  static String path = '/process_screen';
  static String route = 'process_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, TextConstants.processScreen, context.pop),
        body: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            final bool isLoading = state.isLoading;

            final bool isBlocked = state.isLoading || state.error != null;

            void onPressed() async {
              try {
                await context.read<TasksCubit>().postSolution();
                if (context.mounted) {
                  context.push(ResultScreen.path);
                }
              } catch (_) {}
            }

            return Container(
              padding: const EdgeInsets.all(10),
              child: isLoading
                  ? loader()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: customPercentIndicator(
                              state.loadingProcess, state.error),
                        ),
                        customButton(
                            TextConstants.sendResult, onPressed, isBlocked)
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
