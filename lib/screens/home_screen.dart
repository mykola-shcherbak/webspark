import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spark/api/task_api.dart';
import 'package:spark/cubit/tasks_cubit.dart';
import 'package:spark/constants/color_constants.dart';
import 'package:spark/constants/text_constants.dart';
import 'package:spark/screens/process_screen.dart';
import 'package:spark/utils/link_validation_utills.dart';
import 'package:spark/widgets.dart/custom_app_bar.dart';
import 'package:spark/widgets.dart/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String path = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final linkController = TextEditingController();
  bool isError = false;

  @override
  void initState() {
    super.initState();
    linkController.text = TaskApiClient.baseUrl;
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  void onPressed() {
    final isValid = validateLink(linkController.text);
    if (isValid) {
      context.read<TasksCubit>().getTasks(linkController.text);
      context.push(ProcessScreen.path);
    } else {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, TextConstants.homeScreen, null),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextConstants.setUrl),
                    TextField(
                      controller: linkController,
                      onChanged: (value) {
                        setState(() {
                          isError = false;
                        });
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIconConstraints:
                            BoxConstraints.tight(const Size(25, 30)),
                        prefixIcon: Icon(
                          Icons.link,
                          color: isError
                              ? ColorConstants.error
                              : ColorConstants.accentColor,
                          size: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstants.accentColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstants.accentColor),
                        ),
                        errorText: isError ? TextConstants.linkError : null,
                      ),
                      cursorColor: ColorConstants.accentColor,
                    ),
                  ],
                ),
                customButton(TextConstants.startProcess, onPressed, isError)
              ],
            );
          },
        ),
      ),
    );
  }
}
