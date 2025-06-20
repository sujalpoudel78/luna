import 'package:flutter/material.dart';
import 'package:luna/pages/habit_page.dart';
import 'package:luna/pages/theme.dart';

class HabitAdd extends StatefulWidget {
  final VoidCallback onCreate;
  const HabitAdd({super.key,required this.onCreate});

  @override
  State<HabitAdd> createState() => _HabitAddState();
}

class _HabitAddState extends State<HabitAdd> {
  @override
  Widget build(BuildContext context) {
    
    final Function createHabit;

    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(21, 33, 21, 0),
        child: ListView(
          children: [
            Center(child: Text('Add New Task')),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(9),
              ),
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              child: TextField(
                controller: habitController,
                decoration: InputDecoration(
                  hintText: 'Enter Habit Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(onPressed: widget.onCreate, child: Text('Add Habit')),
          ],
        ),
      ),
    );
  }
}
