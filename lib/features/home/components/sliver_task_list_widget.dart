import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/home_controllar.dart';
import 'package:tasky/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeControllar>(
      builder:
          (BuildContext context, HomeControllar controllar, Widget? child) {
            return controllar.isLoding
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : controllar.tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall!.copyWith(fontSize: 24),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: 60),
                    sliver: SliverList.separated(
                      itemCount: controllar.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TaskItemWidget(
                            model: controllar.tasks[index],
                            onChanged: (bool? value) {
                              controllar.doneTasks(value, index);
                            },
                            onDelete: (int id) {
                              controllar.deleteTask(id);
                            },

                            onEdit: () {
                              controllar.loadTaskes();
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  );
          },
    );
  }
}
