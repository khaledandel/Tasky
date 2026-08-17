import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgts/custam_text_form_filed.dart';
import 'package:tasky/models/task_model.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskNameControllar = TextEditingController();

  final TextEditingController taskDescriptionControllar =
      TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
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
                          controllar: taskNameControllar,
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
                          controllar: taskDescriptionControllar,
                          hintText:
                              'Finish onboarding UI and hand off to\ndevs by Thursday.',
                          maxLines: 5,
                        ),
                      ),

                      ////////////////////////////////////////////////////////////////////
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          Switch(
                            value: isHighPriority,
                            onChanged: (bool value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                            // activeTrackColor: Color(0xFF15B86C),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    final taskJson = PreferanceManager().getString('tasks');
                    List<dynamic> listTasks = [];

                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }

                    TaskModel model = TaskModel(
                      id: (listTasks.length + 1),
                      taskName: taskNameControllar.text,
                      taskDescription: taskDescriptionControllar.text,
                      isHighPriority: isHighPriority,
                    );

                    listTasks.add(model.toMap());
                    final taskEncode = jsonEncode(listTasks);
                    await PreferanceManager().setString('tasks', taskEncode);

                    Navigator.of(context).pop(true);
                  }
                },

                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),

                icon: Icon(Icons.add),
                label: Text(
                  "Add Task",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Color(0xFFFFFCFC)),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
