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
  late List<DateTime> _dates;
  late ScrollController _scrollController;
  late PageController _pageController;
  final int _initialIndex = 90;

  double get scrollOffset {
    final screenWidth = MediaQuery.of(context).size.width;
    final tileWidth = screenWidth / 7;
    return _initialIndex * tileWidth;
  }

  @override
  void initState() {
    super.initState();
    _generateDates();
    _scrollController = ScrollController();
    _pageController = PageController();
    // Scroll to today after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _generateDates() {
    final today = DateTime.now();
    _dates = List.generate(
      121,
      (index) => today.subtract(Duration(days: 90 - index)),
    );
  }

  void _scrollToToday() {
    // _pageController.animateToPage(page, duration: duration, curve: curve)
    _pageController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    // final screenWidth = MediaQuery.of(context).size.width;
    // final tileWidth = screenWidth / 7;

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          return DateTile(
            // width: tileWidth,
            date: date,
            isSelected: _isSameDay(date, selectedDate),
            isToday: _isSameDay(date, DateTime.now()),
            onTap: () {
              ref.read(selectedDateProvider.notifier).state = date;
            },
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
