import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/core/widgts/custam_svg_widget.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';

import 'home_controllar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeControllar>(
      create: (BuildContext context) => HomeControllar()..init(),

      child: Consumer<HomeControllar>(
        builder: (BuildContext context, HomeControllar value, Widget? child) {
          final controllar = context.read<HomeControllar>();
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
                    controllar.loadTaskes();
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
                              backgroundImage: value.userImagePath == null
                                  ? AssetImage('assets/images/Avatar.png')
                                  : FileImage(File(value.userImagePath!)),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  "Good Evening , ${value.username} ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge,
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

                        AchievedTasksWidget(
                          totalTasks: value.totalTasks,
                          totalDoneTasks: value.totalDoneTasks,
                          percantage: value.percantage,
                        ),
                        SizedBox(height: 8),
                        HighPriorityTasksWidget(
                          tasks: value.tasks,
                          onTap: (bool? value, int? index) {
                            controllar.doneTasks(value, index);
                          },
                          refresh: () {
                            controllar.loadTaskes();
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
                  value.isLoding
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SliverTaskListWidget(
                          tasks: value.tasks,
                          onTap: (bool? value, int? index) {
                            controllar.doneTasks(value, index);
                          },
                          emptyMessage: 'No Data',
                          onDelete: (int id) {
                            controllar.deleteTask(id);
                          },
                          onEdit: () => controllar.loadTaskes(),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
