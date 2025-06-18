import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:luna/pages/theme.dart';

double fontSize = 18;
double borderRadius = 50;

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

class _HabitPageState extends State<HabitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HABITS')),
      body: Column(
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
              width: MediaQuery.of(context).size.width/7,

              dayStructure: DayStructure.dayNumDayStr,
              todayStyle: commonDayStyle,
              inactiveDayStyle: commonDayStyle,

              activeDayStyle: commonDayStyle,
              borderColor: Colors.transparent,
              todayHighlightStyle: TodayHighlightStyle.withBorder,
              todayHighlightColor: AppTheme.primaryColor,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '---',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
