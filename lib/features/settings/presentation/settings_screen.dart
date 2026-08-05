import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/alarm_settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(alarmDistanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Settings"),
      ),
      body: ListView(
        children: [
          RadioListTile<double>(
            value: 300,
            groupValue: selected,
            title: const Text("300 meters"),
            onChanged: (value) {
              ref.read(alarmDistanceProvider.notifier).state = value!;
            },
          ),
          RadioListTile<double>(
            value: 500,
            groupValue: selected,
            title: const Text("500 meters"),
            onChanged: (value) {
              ref.read(alarmDistanceProvider.notifier).state = value!;
            },
          ),
          RadioListTile<double>(
            value: 700,
            groupValue: selected,
            title: const Text("700 meters"),
            onChanged: (value) {
              ref.read(alarmDistanceProvider.notifier).state = value!;
            },
          ),
          RadioListTile<double>(
            value: 1000,
            groupValue: selected,
            title: const Text("1000 meters"),
            onChanged: (value) {
              ref.read(alarmDistanceProvider.notifier).state = value!;
            },
          ),
        ],
      ),
    );
  }
}