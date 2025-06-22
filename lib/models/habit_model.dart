import 'package:hive/hive.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool completed;

  Habit({required this.title, required this.completed});
}
