import 'package:objectbox/objectbox.dart';
import 'habit.dart';

@Entity()
class HabitCompletion {
  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime completedDate;
  
  final habit = ToOne<Habit>();
  
  String? note;

  HabitCompletion({
    required this.completedDate,
    this.note,
  });
}