import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constans/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController taskNameControllar = TextEditingController();
  final TextEditingController taskDescriptionControllar =
      TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final taskJson = PreferanceManager().getString(StorageKey.tasks);
      List<dynamic> listTasks = [];
      if (taskJson != null) {
        listTasks = jsonDecode(taskJson);
      }
      TaskModel model = TaskModel(
        id: (listTasks.length + 1),
        taskName: taskNameControllar.text,
        taskDescription: taskDescriptionControllar.text,
        isHighPriority: isHighPriority,
      );
      listTasks.add(model.toMap());
      final taskEncode = jsonEncode(listTasks);
      await PreferanceManager().setString(StorageKey.tasks, taskEncode);
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
