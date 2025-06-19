import 'package:flutter/material.dart';

class HabitAdd extends StatelessWidget {
  const HabitAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(9, 39, 9, 0),
        child: Column(
          children: [
            Text('habit add page')
          ],
        ),
      ),
    );
  }
}