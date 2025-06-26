import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:luna/pages/habit_page.dart';
import 'package:luna/pages/theme.dart';
import 'package:luna/models/habit_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime firstofmonth = DateTime(now.year, now.month, 1);

    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    int startingWeekDay = firstofmonth.weekday;

    List<DateTime?> calendarDays = [];

    for (int i = 0; i < startingWeekDay; i++) {
      calendarDays.add(null);
    }

    for (var i = 0; i < daysInMonth; i++) {
      calendarDays.add(DateTime(now.year, now.month, i));
    }

    Color getDayColor(DateTime date, List<Habit> habits) {
      if (habits.isEmpty) return Colors.transparent;
      int completedCount =
          habits.where((habit) {
            return habit.completedDates.any(
              (d) =>
                  d.year == date.year &&
                  d.month == date.month &&
                  d.day == date.day,
            );
          }).length;

      double completionRatio = completedCount / habits.length;

      if (completionRatio == 0) {
        return Colors.transparent;
      } else if (completedCount < habits.length) {
        return AppTheme.primaryColor.withValues(alpha: 0.6);
      } else {
        return AppTheme.primaryColor;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('CALENDAR')),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: calendarDays.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                ),
                itemBuilder: (context, index) {
                  final date = calendarDays[index];
                  if (date == null) {
                    return SizedBox(height: 18, width: 18);
                  }
                  final habits = habitsBox.values.cast<Habit>().toList();
                  final color = getDayColor(date, habits);

                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(child: Text(date.day.toString())),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
