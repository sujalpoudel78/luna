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
  int totalTime = 0;

  @override
  void initState() {
    super.initState();
    _getUsageStats();
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime now = DateTime.now();
      // Set start time to exactly 00 00 
      DateTime startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
      // Set end time to current time
      DateTime endDate = now;

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
      totalTime = 0;

      for (var info in rawStats) {
        final pkg = info.packageName;
        final time = int.tryParse(info.totalTimeInForeground ?? '0') ?? 0;

        // Additional check to make sure the usage data is from today
        if (pkg != null && time > 0) {
          // Check if the last time used was today
          final lastTimeUsed = info.lastTimeUsed;
          if (lastTimeUsed != null) {
            final lastUsedDate = DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(lastTimeUsed) ?? 0,
            ).toLocal();

            // Only include if last used today
            if (lastUsedDate.year == now.year &&
                lastUsedDate.month == now.month &&
                lastUsedDate.day == now.day) {
              appTimeMap[pkg] = (appTimeMap[pkg] ?? 0) + time;
              totalTime += time;
            }
          } else {
            appTimeMap[pkg] = (appTimeMap[pkg] ?? 0) + time;
            totalTime += time;
          }
        }
      }

      List<Map<String, dynamic>> resolvedStats = [];

      for (var entry in appTimeMap.entries) {
        final app = await DeviceApps.getApp(entry.key, true);

        if (_isLauncherApp(entry.key, app)) {
          continue;
        }

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

  // Check if app is a launcher (home screen) app - these should be excluded
  bool _isLauncherApp(String packageName, Application? app) {
    //common launcher package patterns
    final launcherPatterns = [
      'launcher',
      'home',
      '.launcher',
      'trebuchet', // CyanogenMod launcher
      'pixel.launcher', // Google Pixel launcher
      'touchwiz.launcher', // Samsung TouchWiz
      'miui.home', // MIUI home
      'nova.launcher', // Nova launcher
      'actionlauncher', // Action launcher
      'microsoft.launcher', // Microsoft launcher
      'lawnchair', // Lawnchair launcher
      'oneplus.launcher', // OnePlus launcher
      'lineageos.trebuchet', // LineageOS launcher
    ];

    final lowerPackage = packageName.toLowerCase();
    for (String pattern in launcherPatterns) {
      if (lowerPackage.contains(pattern)) {
        return true;
      }
    }

    // Specific launcher package names
    final launcherPackages = [
      'com.miui.home',
      'com.android.launcher',
      'com.android.launcher2',
      'com.android.launcher3',
      'com.google.android.launcher',
      'com.sec.android.app.launcher',
      'com.samsung.android.launcher',
      'com.oneplus.launcher',
      'com.huawei.android.launcher',
      'com.xiaomi.launcher',
      'com.oppo.launcher',
      'com.vivo.launcher',
      'com.lge.launcher2',
      'com.htc.launcher',
      'com.motorola.launcher',
      'com.teslacoilsw.launcher', // Nova Launcher
      'com.actionlauncher.playstore',
      'com.microsoft.launcher',
      'ch.deletescape.lawnchair.plah',
    ];

    return launcherPackages.contains(packageName);
  }

  String _calculatePercentage(int appDuration) {
    if (totalTime == 0) return '0';
    double percentage = (appDuration / totalTime) * 100;
    return percentage.toStringAsFixed(1);
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
            'Today\'s Screen Time:\n${formatDuration(totalTime)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12),
          ..._usageStats.isEmpty
              ? [Text('No data or permission not granted')]
              : _usageStats.map((info) {
                // final int maxDuration = _usageStats.first['duration'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Text('${info['appName']}',style: Theme.of(context).textTheme.titleMedium,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${formatDuration(info['duration'])}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '${_calculatePercentage(info['duration'])}%',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: info['duration'] / totalTime,
                        minHeight: 18,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(18),
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