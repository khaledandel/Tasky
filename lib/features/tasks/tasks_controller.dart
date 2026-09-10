import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constans/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoding = false;
  int? index;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPeriorityTasks = [];

  TasksController() {
    init();
  }

  init() {
    loadTaskes();
  }

  void loadTaskes() async {
    isLoding = true;

    _loadData();

    isLoding = false;
    notifyListeners();
  }

  _loadData() {
    final finalTask = PreferanceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);
      tasks = taskAfterDecode.map((json) {
        return TaskModel.toObjectOfTaskModel(json);
      }).toList();
      todoTasks = tasks.where((element) => !element.isDone).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();
      highPeriorityTasks = tasks
          .where((element) => element.isHighPriority)
          .toList()
          .reversed
          .toList();
    }
  }

  void doneTasks(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;
    final newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadTaskes();
    notifyListeners();
  }

  void doneCompleteTasks(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = value ?? false;
    final newIndex = tasks.indexWhere((e) => e.id == completeTasks[index].id);
    tasks[newIndex] = completeTasks[index];
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadTaskes();
    notifyListeners();
  }

  void doneHighPeriorityTasks(bool? value, int? index) async {
    if (index == null) return;
    highPeriorityTasks[index].isDone = value ?? false;
    final newIndex = tasks.indexWhere(
      (e) => e.id == highPeriorityTasks[index].id,
    );
    tasks[newIndex] = highPeriorityTasks[index];
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadTaskes();
    notifyListeners();
  }

  void deleteTask(int id) async {
    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((task) => task.id == id);
    final updateedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(updateedTask),
    );
    notifyListeners();
  }

  void deleteCompleteTask(int id) async {
    tasks.removeWhere((e) => e.id == id);
    completeTasks.removeWhere((task) => task.id == id);
    final updateedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(updateedTask),
    );
    notifyListeners();
  }

  void deleteHighPeriorityTasks(int id) async {
    tasks.removeWhere((e) => e.id == id);
    highPeriorityTasks.removeWhere((task) => task.id == id);
    final updateedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(updateedTask),
    );
    notifyListeners();
  }
}
