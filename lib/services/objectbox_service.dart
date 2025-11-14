import '../models/habit.dart';
import '../models/habit_completion.dart';
import '../objectbox.g.dart'; // This will be generated

class ObjectBoxService {
  late final Store _store;
  late final Box<Habit> _habitBox;
  late final Box<HabitCompletion> _completionBox;

  static ObjectBoxService? _instance;

  ObjectBoxService._create(this._store) {
    _habitBox = _store.box<Habit>();
    _completionBox = _store.box<HabitCompletion>();
  }

  static Future<ObjectBoxService> create() async {
    if (_instance != null) return _instance!;
    
    final store = await openStore();
    _instance = ObjectBoxService._create(store);
    return _instance!;
  }

  Box<Habit> get habitBox => _habitBox;
  Box<HabitCompletion> get completionBox => _completionBox;

  void close() {
    _store.close();
  }
}