import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ChangeNotifierProvider<TasksController>(
        create: (BuildContext _) => TasksController(),
        builder: (context, _) {
          final controller = context.read<TasksController>();

          return Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'To Do Tasks',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              controller.isLoding
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : controller.todoTasks.isEmpty
                  ? Center(
                      child: Text(
                        "No Data",
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall!.copyWith(fontSize: 24),
                      ),
                    )
                  : Expanded(
                      child: Consumer<TasksController>(
                        builder: (BuildContext context, value, Widget? child) {
                          return TaskListWidget(
                            tasks: value.todoTasks,
                            onTap: (bool? value, int? index) {
                              controller.doneTasks(value, index);
                            },
                            emptyMessage: 'No Tasks Founded',
                            onDelete: (int id) {
                              controller.deleteTask(id);
                            },
                            onEdit: controller.loadTaskes,
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
