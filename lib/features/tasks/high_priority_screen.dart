import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: ChangeNotifierProvider<TasksController>(
        create: (BuildContext _) => TasksController(),
        builder: (context, _) {
          final controller = context.read<TasksController>();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.isLoding
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : controller.highPeriorityTasks.isEmpty
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
                        child: Consumer<TasksController>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                                return TaskListWidget(
                                  tasks: value.highPeriorityTasks,
                                  onTap: (bool? value, int? index) {
                                    controller.doneHighPeriorityTasks;
                                    controller.loadTaskes();
                                  },
                                  emptyMessage: 'No Tasks Founded',
                                  onDelete: (int id) {
                                    controller.deleteHighPeriorityTasks(id);
                                  },
                                  onEdit: () => controller.loadTaskes(),
                                );
                              },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
