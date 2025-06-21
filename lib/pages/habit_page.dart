import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:luna/models/habit_model.dart';
import 'package:luna/pages/habit_add.dart';
import 'package:luna/pages/theme.dart';

final habitsBox = Hive.box('habitsBox');

final commonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: AppTheme.textColor,
);

final commonDayStyle = DayStyle(
  borderRadius: 50,
  dayNumStyle: commonTextStyle,
  dayStrStyle: commonTextStyle,
);

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  void createNewHabit(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const HabitAdd());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HABITS')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            headerProps: EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              monthStyle: commonTextStyle,
              dateFormatter: DateFormatter.fullDateDayAsStrMY(),
              selectedDateStyle: commonTextStyle,
            ),
            dayProps: EasyDayProps(
              width: MediaQuery.of(context).size.width / 7,
              dayStructure: DayStructure.dayNumDayStr,
              todayStyle: commonDayStyle,
              inactiveDayStyle: commonDayStyle,
              activeDayStyle: commonDayStyle,
              borderColor: Colors.transparent,
              todayHighlightStyle: TodayHighlightStyle.withBorder,
              todayHighlightColor: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 27),
          ElevatedButton(
            onPressed: habitsBox.clear,
            child: const Text('Clear'),
          ),
          const SizedBox(height: 27),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: habitsBox.listenable(),
              builder: (context, Box box, _) {
                final habits = box.values.toList();
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppTheme.surfaceColor,
                      ),
                      child: ListTile(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => Container(
                                  margin: EdgeInsets.all(18),
                                  child: FilledButton(
                                    onPressed: () async {
                                      await habitsBox.deleteAt(index);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Icon(Icons.delete),
                                    ),
                                  ),
                                ),
                          );
                        },
                        leading: Icon(Icons.person_search),
                        title: Text(
                          habits[index],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          'data',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        trailing: Checkbox(value: false, onChanged: (value) {}),
                        onTap: () {},
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 18),
                  itemCount: habits.length,
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () => createNewHabit(context),
            splashColor: AppTheme.accentColor,
            child: Icon(Icons.add, color: AppTheme.textColor),
          ),
        ],
      ),
    );
  }
}
