import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:luna/pages/theme.dart';
import 'package:luna/models/habit_model.dart';

class HabitAdd extends StatelessWidget {
  const HabitAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final habitController = TextEditingController();

    void addHabit() {
      final habitName = habitController.text.trim();
      if (habitName.isNotEmpty) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day); // normalize

        Hive.box<Habit>('habitsBox').add(
          Habit(
            title: habitName,
            completedDates: [],
            createdAt: today, // <-- add this line
          ),
        );

        Navigator.pop(context);
      }
    }

    return Padding(
      // padding: const EdgeInsets.fromLTRB(21, 33, 21, 0),
      padding: EdgeInsets.fromLTRB(
        21,
        33,
        21,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              'Add New Task',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            child: TextField(
              controller: habitController,
              decoration: const InputDecoration(
                hintText: 'Enter Habit Name',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: addHabit,
            child: Text(
              'Add Habit',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
