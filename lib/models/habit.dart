import 'package:objectbox/objectbox.dart';

@Entity()
class Habit {
  @Id()
  int id = 0;

  String name;
  String? description;
  
  @Property(type: PropertyType.date)
  DateTime createdAt;
  
  // Which days of the week (1=Monday, 7=Sunday)
  List<int> weekDays;
  
  int currentStreak;
  int longestStreak;
  
  // For ordering/priority
  int sortOrder;
  
  bool isArchived;

  Habit({
    required this.name,
    this.description,
    required this.createdAt,
    required this.weekDays,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.sortOrder = 0,
    this.isArchived = false,
  });
}
