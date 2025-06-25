import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:luna/models/habit_model.dart';
import 'package:luna/pages/home_page.dart';
import 'package:luna/pages/theme.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());

  await Hive.openBox('notesBox');
  await Hive.openBox<Habit>('habitsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 21,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luna',
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}
