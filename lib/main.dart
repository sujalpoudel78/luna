import 'package:flutter/material.dart';
import 'package:luna/pages/home_page.dart';
import 'package:luna/pages/notes_page.dart';
import 'package:luna/pages/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9,right: 9,top: 0,bottom: 21),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luna',
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: HomePage(),
        routes: {
          '/notesPage':(context) => const NotesPage()
        },
      ),
    );
  }
}