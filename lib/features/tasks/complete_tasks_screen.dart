import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ChangeNotifierProvider<TasksController>(
        create: (BuildContext context) => TasksController(),
        builder: (context, _) {
          final controller = context.read<TasksController>();
          return Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Completed Tasks',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              controller.isLoding
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : controller.completeTasks.isEmpty
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
                        builder:
                            (
                              BuildContext context,
                              TasksController value,
                              Widget? child,
                            ) {
                              return TaskListWidget(
                                tasks: value.completeTasks,
                                onTap: (bool? value, int? index) {
                                  controller.doneCompleteTasks(value, index);
                                  controller.loadTaskes();
                                },
                                emptyMessage: 'No Tasks Founded',
                                onDelete: (int id) {
                                  controller.deleteCompleteTask(id);
                                },
                                onEdit: () => controller.loadTaskes(),
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
