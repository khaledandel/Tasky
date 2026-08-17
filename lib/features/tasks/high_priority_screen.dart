import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  bool? isLoding = false;
  List<TaskModel> highPeriorityTasks = [];
  int? index;

  @override
  void initState() {
    _loadTaskes();
    super.initState();
  }

  void _loadTaskes() async {
    setState(() {
      isLoding = true;
    });

    final finalTask = PreferanceManager().getString('tasks');

    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);

      setState(() {
        highPeriorityTasks = taskAfterDecode.map((element) {
          return TaskModel.toObjectOfTaskModel(element);
        }).toList();
        highPeriorityTasks = highPeriorityTasks
            .where((element) => element.isHighPriority)
            .toList()
            .reversed
            .toList();
      });
    }

    setState(() {
      isLoding = false;
    });
  }

  void _deleteTask(int id) async {
    List<TaskModel> tasks = [];
    final finalTask = PreferanceManager().getString('tasks');

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.toObjectOfTaskModel(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        highPeriorityTasks.removeWhere((task) => task.id == id);
      });
      final updateedTask = tasks.map((element) => element.toMap()).toList();
      await PreferanceManager().setString('tasks', jsonEncode(updateedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoding!
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : highPeriorityTasks.isEmpty
            ? Center(
                child: Text(
                  "No Data",
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(fontSize: 24),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: TaskListWidget(
                      tasks: highPeriorityTasks,
                      onTap: (bool? value, int? index) async {
                        setState(() {
                          highPeriorityTasks[index!].isDone = value ?? false;
                        });

                        final allData = PreferanceManager().getString('tasks');

                        if (allData != null) {
                          final List<TaskModel> allDataList =
                              (jsonDecode(allData) as List)
                                  .map(
                                    (element) =>
                                        TaskModel.toObjectOfTaskModel(element),
                                  )
                                  .toList();

                          final newIndex = allDataList.indexWhere(
                            (e) => e.id == highPeriorityTasks[index!].id,
                          );
                          allDataList[newIndex] = highPeriorityTasks[index!];
                          await PreferanceManager().setString(
                            'tasks',
                            jsonEncode(
                              allDataList.map((e) => e.toMap()).toList(),
                            ),
                          );
                          _loadTaskes();
                        }
                      },
                      emptyMessage: 'No Tasks Founded',
                      onDelete: (int id) {
                        _deleteTask(id);
                      },
                      onEdit: () => _loadTaskes(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
