import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTile extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;
  final double? width;

  const DateTile({
    super.key,
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEE').format(date);
    final dayNumber = DateFormat('d').format(date);
    final tileWidth = width ?? 60;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: tileWidth,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isToday ? Border.all(color: Colors.black, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              dayNumber,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
