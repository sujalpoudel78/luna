import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:luna/pages/notes_page.dart';
import 'package:luna/pages/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildGridItem(String iconPath, String label, String description) {
      return Container(
        padding: EdgeInsets.all(18),
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
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Container(
              padding: EdgeInsets.all(9),
              width: double.infinity,
              height: MediaQuery.of(context).size.width,
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
                    onTap: () {},
                    child: buildGridItem(
                      'assets/icons/list-check.svg',
                      '---',
                      '---',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          //gestures on iOS wont work with this
                          transitionDuration: Duration(milliseconds: 180),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  NotesPage(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            final offsetAnimation = Tween<Offset>(
                              begin: Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            );

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: buildGridItem(
                      'assets/icons/book.svg',
                      'Notes',
                      'Quick Notes',
                    ),
                  ),
                  buildGridItem('assets/icons/sapling.svg', '---', '---'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
