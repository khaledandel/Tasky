import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constans/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class HomeControllar extends ChangeNotifier {
  // List<TaskModel> tasksList = [];
  String? username;
  String? userImagePath;
  List<TaskModel> tasks = [];

  bool isLoding = false; //  CircularProgressIndicator

  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percantage = 0;

  void init() {
    laodUserImage();
    loadUserName();
    loadTaskes();
  }

  void loadUserName() async {
    username = PreferanceManager().getString(StorageKey.username);
    notifyListeners();
  }

  void loadTaskes() async {
    isLoding = true;
    final finalTask = PreferanceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);
      tasks = taskAfterDecode.map((json) {
        return TaskModel.toObjectOfTaskModel(json);
      }).toList();
      calcPercent();
    }
    isLoding = false;
    notifyListeners();
  }

  void calcPercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percantage = totalTasks == 0 ? 0 : (totalDoneTasks / totalTasks);
    notifyListeners();
  }

  void doneTasks(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calcPercent();
    final updatedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    calcPercent();
    final updatedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString('tasks', jsonEncode(updatedTask));
    notifyListeners();
  }

  void laodUserImage() {
    userImagePath = PreferanceManager().getString('user_image');
    notifyListeners();
  }
}
