import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:luna/models/habit_model.dart';
import 'package:luna/pages/habit_add.dart';
import 'package:luna/pages/theme.dart';

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

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

final Box habitsBox = Hive.box('habitsBox');

  final habitController = TextEditingController();
class _HabitPageState extends State<HabitPage> {

  void addHabit() {
    final habitName = habitController.text.trim();
    if (habitName.isNotEmpty) {
      setState(() {
      habitsBox.add(habitName);
      habitController.clear();
      });
    }
  }

  void createNewHabit() {
    setState(() {
      showModalBottomSheet(context: context, builder: (context) => HabitAdd(onCreate: addHabit,));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> habits = habitsBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('HABITS')),
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
          SizedBox(height: 27),
          ElevatedButton(onPressed: habitsBox.clear, child: Text('clear')),
          SizedBox(height: 27),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: AppTheme.dividerColor),
                  child: ListTile(title: Text(habits[index])),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 18),
              itemCount: habits.length,
            ),
          ),
          FloatingActionButton(
            onPressed: createNewHabit,
            splashColor: AppTheme.accentColor,
            child: Icon(Icons.add, color: AppTheme.textColor),
          ),
        ],
      ),
    );
  }
}
