import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/Enums/task_item_action_enum.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/themes/theme_controlar.dart';
import 'package:tasky/core/widgts/custam_text_form_filed.dart';
import 'package:tasky/core/widgts/cutsam_cheak_box.dart';
import 'package:tasky/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged(bool? value),
    required this.onDelete(int id),
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 58,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeControlar.isDark()
                ? Colors.transparent
                : Color(0xFFD1DAD6),
          ),
        ),

        child: Row(
          children: [
            SizedBox(width: 8),

            CutsamCheakBox(
              value: model.isDone,
              onChanged: (bool? value) => onChanged(value),
            ),

            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    model.taskName,
                    style: TextStyle(
                      color: ThemeControlar.isDark()
                          ? model.isDone
                                ? Color(0xFFA0A0A0)
                                : Color(0xFFFFFCFC)
                          : model.isDone
                          ? Color(0xFF6A6A6A)
                          : Color(0xFF161F1B),
                      fontSize: 16,
                      decoration: model.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  if (model.taskDescription.isNotEmpty)
                    Text(
                      model.taskDescription,
                      style: TextStyle(
                        color: ThemeControlar.isDark()
                            ? model.isDone
                                  ? Color(0xFFA0A0A0)
                                  : Color(0xFFFFFCFC)
                            : model.isDone
                            ? Color(0xFF6A6A6A)
                            : Color(0xFF161F1B),
                        fontSize: 14,
                        decoration: model.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                ],
              ),
            ),

            PopupMenuButton<TaskItemActionEnum>(
              icon: Icon(
                Icons.more_vert,
                color: ThemeControlar.isDark()
                    ? model.isDone
                          ? Color(0xFFA0A0A0)
                          : Color(0xFFFFFCFC)
                    : model.isDone
                    ? Color(0xFF6A6A6A)
                    : Color(0xFF161F1B),
              ),

              onSelected: (value) async {
                switch (value) {
                  case TaskItemActionEnum.markAsDone:
                    // onChanged(!model.isDone);
                    onChanged(true);

                  case TaskItemActionEnum.edit:
                    final result = await _showBottomSheet(context, model);
                    if (result == true) {
                      onEdit();
                    }
                  case TaskItemActionEnum.delete:
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Task',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          content: Text(
                            'Are You Sure You Want To Delete Task',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onDelete(model.id);
                              },
                              child: Text(
                                'Delete ',
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                }
              },

              itemBuilder: (context) => TaskItemActionEnum.values
                  .map(
                    (element) => PopupMenuItem<TaskItemActionEnum>(
                      child: Text(element.name),
                      value: element,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showBottomSheet(BuildContext context, TaskModel model) {
    bool isHighPriority = true;
    final TextEditingController taskNameControllar = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController taskDescriptionControllar =
        TextEditingController(text: model.taskDescription);
    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: CustamTextFormFiled(
                                title: 'Task Name',
                                controllar: taskNameControllar,
                                hintText: 'Finish UI design for login screen',
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? false) {
                                    return "Enter Task Name";
                                  }
                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 8),

                            SizedBox(
                              width: double.infinity,
                              child: CustamTextFormFiled(
                                title: 'Task Description',
                                controllar: taskDescriptionControllar,
                                hintText:
                                    'Finish onboarding UI and hand off to\ndevs by Thursday.',
                                maxLines: 5,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),

                                Switch(
                                  value: isHighPriority,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isHighPriority = value;
                                    });
                                  },
                                  // activeTrackColor: Color(0xFF15B86C),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          final taskJson = PreferanceManager().getString(
                            'tasks',
                          );
                          List<dynamic> listTasks = [];
                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameControllar.text,
                            taskDescription: taskDescriptionControllar.text,
                            isHighPriority: isHighPriority,
                            // لو حطيتها هيشيل التاسك اللي هتتعدل من الكومبليت تاسك
                            //التاسك اللي في الكومبليت فقط
                            //الباقي هيكون طبيعي
                            // isDone: model.isDone,
                          );
                          final item = listTasks.firstWhere(
                            (e) => e['id'] == model.id,
                          );
                          final index = listTasks.indexOf(item);
                          listTasks[index] = newModel.toMap();
                          final taskEncode = jsonEncode(listTasks);
                          await PreferanceManager().setString(
                            'tasks',
                            taskEncode,
                          );
                          Navigator.of(context).pop(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),

                      icon: Icon(Icons.edit),
                      label: Text(
                        "Edit Task",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
