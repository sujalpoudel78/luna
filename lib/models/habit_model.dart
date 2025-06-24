import 'package:hive/hive.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final List<DateTime> completedDates;

  Habit({required this.title, required this.completedDates});
}
