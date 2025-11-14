import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app.dart' show MainApp;

void main() {
  runApp(ProviderScope(child: const MainApp()));
}
