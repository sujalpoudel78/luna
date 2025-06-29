import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:luna/pages/calendar_page.dart';
import 'package:luna/pages/habit_add.dart';
import 'package:luna/models/habit_model.dart';
import 'package:luna/pages/home_page.dart';
import 'package:luna/pages/theme.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

final habitsBox = Hive.box<Habit>('habitsBox');

final commonTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: AppTheme.textColor,
);

final commonDayStyle = DayStyle(
  borderRadius: 50,
  dayNumStyle: commonTextStyle,
  dayStrStyle: commonTextStyle,
);

class _HabitPageState extends State<HabitPage> {
  void createNewHabit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const HabitAdd(),
    );
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HABITS'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, pageNavigateAnimation(CalendarPage()));
            },
            icon: Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            EasyDateTimeLine(
              initialDate: selectedDate,
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
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
            // const SizedBox(height: 18),
            // ElevatedButton(
            //   onPressed: () {
            //     habitsBox.clear();
            //   },
            //   child: Text('clear'),
            // ),
            const SizedBox(height: 18),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: habitsBox.listenable(),
                builder: (context, Box box, _) {
                  final habits =
                      box.values
                          .cast<Habit>()
                          .where(
                            (habit) => !habit.createdAt.isAfter(selectedDate),
                          )
                          .toList();

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final normalized = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                      );

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 9),
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
                                    margin: const EdgeInsets.all(9),
                                    child: FilledButton(
                                      onPressed: () async {
                                        await habitsBox.deleteAt(index);
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Icon(
                                          Icons.delete,
                                          color: AppTheme.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                            );
                          },
                          title: Text(
                            habits[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          trailing: Checkbox(
                            value: habits[index].completedDates.any(
                              (date) =>
                                  date.year == normalized.year &&
                                  date.month == normalized.month &&
                                  date.day == normalized.day,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  if (!habits[index].completedDates.any(
                                    (date) =>
                                        date.year == normalized.year &&
                                        date.month == normalized.month &&
                                        date.day == normalized.day,
                                  )) {
                                    habits[index].completedDates.add(
                                      normalized,
                                    );
                                  }
                                } else {
                                  habits[index].completedDates.removeWhere(
                                    (date) =>
                                        date.year == normalized.year &&
                                        date.month == normalized.month &&
                                        date.day == normalized.day,
                                  );
                                }
                                habits[index].save();
                              });
                            },
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
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
      ),
    );
  }
}
