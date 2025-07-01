import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:luna/pages/theme.dart';
import 'dart:async';
import 'package:device_apps/device_apps.dart';

class Screentime extends StatefulWidget {
  const Screentime({super.key});

  @override
  State<Screentime> createState() => _ScreentimeState();
}

class _ScreentimeState extends State<Screentime> {
  List<Map<String, dynamic>> _usageStats = [];

  @override
  void initState() {
    super.initState();
    _getUsageStats();
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));

      bool hasPermission = await UsageStats.checkUsagePermission() ?? false;
      if (!hasPermission) {
        const intent = AndroidIntent(
          action: 'android.settings.USAGE_ACCESS_SETTINGS',
        );
        await intent.launch();
        return;
      }

      List<UsageInfo> rawStats = await UsageStats.queryUsageStats(
        startDate,
        endDate,
      );

      Map<String, int> appTimeMap = {};
      for (var info in rawStats) {
        final pkg = info.packageName;
        final time = int.tryParse(info.totalTimeInForeground ?? '0') ?? 0;

        if (pkg != null) {
          appTimeMap[pkg] = (appTimeMap[pkg] ?? 0) + time;
        }
      }

      List<Map<String, dynamic>> resolvedStats = [];

      for (var entry in appTimeMap.entries) {
        final app = await DeviceApps.getApp(entry.key, true);
        resolvedStats.add({
          'appName': app?.appName ?? entry.key,
          'duration': entry.value,
        });
      }

      resolvedStats.sort((a, b) => b['duration'].compareTo(a['duration']));

      setState(() {
        _usageStats = resolvedStats.take(3).toList();
      });
    } catch (e) {
      print("Error fetching usage stats: $e");
    }
  }

  String formatDuration(int millis) {
    final seconds = (millis / 1000).round();
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (hours < 1)
      return '$remainingMinutes min';
    else
      return '$hours hours $remainingMinutes min';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppTheme.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Screen Time',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12),
          ..._usageStats.isEmpty
              ? [Text('No data or permission not granted')]
              : _usageStats.map((info) {
                  final int maxDuration = _usageStats.first['duration'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${info['appName']} - ${formatDuration(info['duration'])}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: info['duration'] / maxDuration,
                          minHeight: 6,
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  );
                }).toList(),
        ],
      ),
    );
  }
}
