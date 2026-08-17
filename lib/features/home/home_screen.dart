import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgts/custam_svg_widget.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/achieved_tasks_widget.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String? username;
  String? userImagePath;
  List<TaskModel> tasks = [];

  bool isLoding = false; //  CircularProgressIndicator

  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percantage = 0;

  @override
  void initState() {
    super.initState();
    _laodUserImage();
    _loadUserName();
    _loadTaskes();
  }

  void _loadUserName() async {
    setState(() {
      username = PreferanceManager().getString('username');
    });
  }

  void _loadTaskes() async {
    setState(() {
      isLoding = true;
    });
    final finalTask = PreferanceManager().getString('tasks');
    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);
      setState(() {
        tasks = taskAfterDecode.map((json) {
          return TaskModel.toObjectOfTaskModel(json);
        }).toList();
        _calcPercent();
      });
    }

    setState(() {
      isLoding = false;
    });
  }

  void _calcPercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percantage = totalTasks == 0 ? 0 : (totalDoneTasks / totalTasks);
  }

  void _doneTasks(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calcPercent();
    });

    final updatedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString('tasks', jsonEncode(updatedTask));
  }

  _deleteTask(int id) async {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calcPercent();
    });
    final updatedTask = tasks.map((element) => element.toMap()).toList();
    await PreferanceManager().setString('tasks', jsonEncode(updatedTask));
  }

  void _laodUserImage() {
    setState(() {
      userImagePath = PreferanceManager().getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 168,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Addtask();
                },
              ),
            );
            if (result != null && result) {
              _loadTaskes();
            }
          },
          icon: Icon(Icons.add),
          label: Text(
            "Add New Task",
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: Color(0xFFFFFCFC)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/images/Avatar.png')
                            : FileImage(File(userImagePath!)),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "Good Evening , $username ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "One task at a time.One step\ncloser.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Yuhuu ,Your work Is",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "almost done !",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          CustamSvgWidget.WithoutColorFilter(
                            path: 'assets/images/wavingHand.svg',
                            height: 32,
                            width: 32,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ///// Shared Widget in Folder Widgets
                  AchievedTasksWidget(
                    totalTasks: totalTasks,
                    totalDoneTasks: totalDoneTasks,
                    percantage: percantage,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTasks(value, index);
                    },
                    refresh: () {
                      _loadTaskes();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            isLoding
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTasks(value, index);
                    },
                    emptyMessage: 'No Data',
                    onDelete: (int id) {
                      _deleteTask(id);
                    },
                    onEdit: () => _loadTaskes(),
                  ),
          ],
        ),
      ),
    );
  }
}
