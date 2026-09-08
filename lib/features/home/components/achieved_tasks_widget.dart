import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/home_controllar.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    // required this.totalTasks,
    // required this.totalDoneTasks,
    // required this.percantage,
  });

  // final int totalTasks;
  // final int totalDoneTasks;
  // final double percantage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeControllar>(
      builder: (BuildContext context, HomeControllar controllar, Widget? child) {
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
              children: [
                Column(
                  children: [
                    Text(
                      'Achieved Tasks',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    SizedBox(height: 4),
                    Text(
                      '${controllar.totalDoneTasks} Out of ${controllar.totalTasks} Done',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),

                Stack(
                  alignment: .center,
                  children: [
                    Transform.rotate(
                      angle: -pi / 2,
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          value: controllar.percantage,
                          valueColor: AlwaysStoppedAnimation(Color(0xFF15B86C)),
                          strokeWidth: 4,

                          backgroundColor: Color(0xFF6D6D6D),
                        ),
                      ),
                    ),
                    Text(
                      '${((controllar.percantage) * 100).toInt()}%',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
