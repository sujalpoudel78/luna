import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:luna/pages/habit_page.dart';
import 'package:luna/pages/notes_page.dart';
import 'package:luna/pages/theme.dart';

Route pageNavigateAnimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildGridItem(String iconPath, String label) {
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppTheme.borderColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 45,
              width: 45,
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color ?? Colors.white,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 9),
            Text(label, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 9),
          ],
        ),
      );
    }

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text('LUNA'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: AppTheme.borderColor, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Feature Coming Soon',
                        style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.all(9),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: AppTheme.borderColor, width: 1),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            pageNavigateAnimation(HabitPage()),
                          );
                        },
                        child: buildGridItem(
                          'assets/icons/list-check.svg',
                          'Habit Tracker',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            pageNavigateAnimation(NotesPage()),
                          );
                        },
                        child: buildGridItem('assets/icons/book.svg', 'Notes'),
                      ),
                      buildGridItem('assets/icons/sapling.svg', '---'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
