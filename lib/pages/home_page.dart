import 'package:flutter/material.dart';
import 'package:luna/pages/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildGridItem(String label) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppTheme.borderColor, width: 1),
        ),
        child: Center(
          child: Text(label, style: Theme.of(context).textTheme.titleLarge),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
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
                    buildGridItem('page'),
                    buildGridItem('page'),
                    buildGridItem('page'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
