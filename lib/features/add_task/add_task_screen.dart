import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgts/custam_text_form_filed.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';

class Addtask extends StatelessWidget {
  const Addtask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: controller.key,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: CustamTextFormFiled(
                              title: 'Task Name',
                              controllar: controller.taskNameControllar,
                              hintText: 'Finish UI design for login screen',
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Enter Task Name";
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 8),

                          SizedBox(
                            width: double.infinity,
                            child: CustamTextFormFiled(
                              title: 'Task Description',
                              controllar: controller.taskDescriptionControllar,
                              hintText:
                                  'Finish onboarding UI and hand off to\ndevs by Thursday.',
                              maxLines: 5,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "High Priority",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),

                              Consumer<AddTaskController>(
                                builder:
                                    (
                                      BuildContext context,
                                      value,
                                      Widget? child,
                                    ) {
                                      return Switch(
                                        value: value.isHighPriority,
                                        onChanged: (bool value) {
                                          controller.toggle(value);
                                        },
                                        // activeTrackColor: Color(0xFF15B86C),
                                      );
                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AddTaskController>().addTask(context);
                    },
                    /////////////////////////////////////////////////////
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),

                    icon: Icon(Icons.add),
                    label: Text(
                      "Add Task",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Color(0xFFFFFCFC),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
