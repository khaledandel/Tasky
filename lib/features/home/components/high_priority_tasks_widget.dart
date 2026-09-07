import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/home_controllar.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';
import 'package:tasky/core/themes/theme_controlar.dart';
import 'package:tasky/core/widgts/cutsam_cheak_box.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeControllar>(
      builder:
          (BuildContext context, HomeControllar controllar, Widget? child) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: .circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'High Priority Tasks',
                            style: TextStyle(
                              color: Color(0xFF15B86C),
                              fontSize: 14,
                              fontWeight: .w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          ...controllar.tasks.reversed
                              .where((e) => e.isHighPriority)
                              .take(4)
                              .map((element) {
                                return Row(
                                  children: [
                                    CutsamCheakBox(
                                      value: element.isDone,
                                      onChanged: (bool? value) {
                                        final index = controllar.tasks
                                            .indexWhere(
                                              (e) => e.id == element.id,
                                            );
                                        controllar.doneTasks(value, index);
                                      },
                                    ),
                                    Flexible(
                                      child: Text(
                                        element.taskName,
                                        style: element.isDone
                                            ? Theme.of(
                                                context,
                                              ).textTheme.titleLarge
                                            : Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),

                    Container(
                      height: 56,
                      width: 48,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        border: .all(
                          color: ThemeControlar.isDark()
                              ? Color(0xFF6E6E6E)
                              : Color(0xFFD1DAD6),
                        ),
                      ),

                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HighPriorityScreen();
                              },
                            ),
                          );
                          controllar.loadTaskes();
                        },
                        child: SvgPicture.asset(
                          'assets/images/arrow_up_right.svg',
                          height: 24,
                          width: 24,

                          colorFilter: ColorFilter.mode(
                            ThemeControlar.isDark()
                                ? Color(0xFFC6C6C6)
                                : Color(0xFF3A4640),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
    );
  }
}
