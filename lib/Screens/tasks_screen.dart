import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool? isLoding = false;
  List<TaskModel> toDoTasks = [];

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
        toDoTasks = taskAfterDecode.map((element) {
          return TaskModel.toObjectOfTaskModel(element);
        }).toList();
        toDoTasks = toDoTasks
            .where((element) => element.isDone == false)
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
        toDoTasks.removeWhere((task) => task.id == id);
      });
      final updateedTask = tasks.map((element) => element.toMap()).toList();
      await PreferanceManager().setString('tasks', jsonEncode(updateedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'To Do Tasks',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          isLoding!
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : toDoTasks.isEmpty
              ? Center(
                  child: Text(
                    "No Data",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 24),
                  ),
                )
              : Expanded(
                  child: TaskListWidget(
                    tasks: toDoTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        toDoTasks[index!].isDone = value ?? false;
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
                          (e) => e.id == toDoTasks[index!].id,
                        );
                        allDataList[newIndex] = toDoTasks[index!];
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
                    onEdit: _loadTaskes,
                  ),
                ),
        ],
      ),
    );
  }
}
