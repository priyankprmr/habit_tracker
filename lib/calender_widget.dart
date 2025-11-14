import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/date_tile.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

class CalenderWidget extends ConsumerStatefulWidget {
  const CalenderWidget({super.key});

  @override
  ConsumerState<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends ConsumerState<CalenderWidget> {
  late PageController _pageController;
  late List<List<DateTime>> _weekPages;
  late int _initialPage;

  @override
  void initState() {
    super.initState();
    _generateWeekPages();
    _pageController = PageController(initialPage: _initialPage);
  }

  void _generateWeekPages() {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    // Find the start of current week (assuming week starts on Monday)
    final currentWeekStart = normalizedToday.subtract(
      Duration(days: normalizedToday.weekday - 1),
    );

    // Generate 52 weeks (26 past weeks + current week + 25 future weeks)
    _weekPages = [];
    for (int i = -26; i <= 25; i++) {
      final weekStart = currentWeekStart.add(Duration(days: i * 7));
      final week = List.generate(
        7,
        (day) => weekStart.add(Duration(days: day)),
      );
      _weekPages.add(week);
    }

    _initialPage = 26; // Current week is at index 26
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);

    return Container(
      height: 90,

      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _weekPages.length,
        itemBuilder: (context, pageIndex) {
          final weekDates = _weekPages[pageIndex];

          return Row(
            children: weekDates.map((date) {
              return Expanded(
                child: DateTile(
                  date: date,
                  isSelected: _isSameDay(date, selectedDate),
                  isToday: _isSameDay(date, DateTime.now()),
                  onTap: () {
                    ref.read(selectedDateProvider.notifier).state = date;
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
