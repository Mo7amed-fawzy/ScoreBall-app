import 'dart:async';
import 'dart:io';

import 'package:basketball_counter_app/core/cache_helper.dart';
import 'package:basketball_counter_app/core/func/add_foul.dart';
import 'package:basketball_counter_app/core/service_locator.dart';
import 'package:basketball_counter_app/ui/widgets/animated_button.dart';
import 'package:basketball_counter_app/ui/widgets/team_column.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class PointsCounterScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const PointsCounterScreen({
    super.key,
    required this.isDark,
    required this.toggleTheme,
  });

  @override
  State<PointsCounterScreen> createState() => _PointsCounterScreenState();
}

class _PointsCounterScreenState extends State<PointsCounterScreen> {
  int teamAPoints = getIt<CacheHelper>().getData(key: 'teamAPoints') ?? 0;
  int teamBPoints = getIt<CacheHelper>().getData(key: 'teamBPoints') ?? 0;
  int foulsA = 0;
  int foulsB = 0;

  List<String> history = [];

  // Timer
  int seconds = 12 * 60;
  Timer? timer;

  // Screenshot
  final ScreenshotController screenshotController = ScreenshotController();

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        timer?.cancel();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Time's up!",
                    style: Theme.of(context).textTheme.bodyMedium)),
          );
        }
      }
    });
  }

  void pauseTimer() => timer?.cancel();
  void resetTimer() => setState(() => seconds = 12 * 60);

  void updatePoints(String team, int value) async {
    if (team == 'A') {
      teamAPoints += value;
      await getIt<CacheHelper>()
          .saveData(key: 'teamAPoints', value: teamAPoints);
    } else {
      teamBPoints += value;
      await getIt<CacheHelper>()
          .saveData(key: 'teamBPoints', value: teamBPoints);
    }
    setState(() {
      final now = DateTime.now();
      history.add(
          "[${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}] Team $team +$value → $teamAPoints - $teamBPoints");
    });
  }

  void _handleAddFoul(String team) {
    addFoul(
      team: team,
      setState: setState,
      foulsA: foulsA,
      foulsB: foulsB,
      updateFoulsA: (val) => foulsA = val,
      updateFoulsB: (val) => foulsB = val,
      addToHistory: (msg) => history.add(msg),
    );
  }

  void resetAll() async {
    await getIt<CacheHelper>()
        .saveData(key: 'teamAPoints', value: teamAPoints = 0);
    await getIt<CacheHelper>()
        .saveData(key: 'teamBPoints', value: teamBPoints = 0);
    setState(() {
      foulsA = 0;
      foulsB = 0;
      history.add("Reset Points and Fouls");
    });
  }

  Future<void> shareScore() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final tempDir = Directory.systemTemp;
      final file = await File('${tempDir.path}/basketball_score.png').create();
      await file.writeAsBytes(image);

      final xfile = XFile(file.path);
      await Share.shareXFiles([xfile], text: 'Basketball Match Score');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Basketball Counter',
            style: theme.textTheme.titleLarge!.copyWith(color: Colors.white)),
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            tooltip: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
            onPressed: widget.toggleTheme,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) =>
                  RotationTransition(turns: anim, child: child),
              child: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                key: ValueKey(isDark),
                color: isDark ? Colors.orangeAccent : Colors.deepPurpleAccent,
              ),
            ),
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: LayoutBuilder(builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Timer Card with theme-aware gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [colors.surfaceVariant, colors.primary]
                            : [colors.primaryContainer, colors.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black54 : Colors.black26,
                          offset: const Offset(2, 4),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('$minutes:$secs',
                            style: TextStyle(
                                fontSize: isMobile ? 36 : 48,
                                fontWeight: FontWeight.bold,
                                color: colors.onPrimary)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: [
                            AnimatedButton(
                                label: "Start",
                                onPressed: startTimer,
                                color: colors.secondary),
                            AnimatedButton(
                                label: "Pause",
                                onPressed: pauseTimer,
                                color: isDark
                                    ? colors.tertiaryContainer
                                    : colors.tertiary),
                            AnimatedButton(
                                label: "Reset",
                                onPressed: resetTimer,
                                color: colors.error),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Scoreboard area
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TeamColumn(
                        teamName: "Team A",
                        points: teamAPoints,
                        fouls: foulsA,
                        onAddPoints: (value) => updatePoints('A', value),
                        onAddFoul: () => _handleAddFoul('A'),
                        isMobile: isMobile,
                      ),
                      if (!isMobile)
                        SizedBox(
                          height: 500,
                          child: VerticalDivider(
                            indent: 50,
                            endIndent: 50,
                            color: theme.dividerColor,
                            thickness: 1,
                          ),
                        ),
                      TeamColumn(
                        teamName: "Team B",
                        points: teamBPoints,
                        fouls: foulsB,
                        onAddPoints: (value) => updatePoints('B', value),
                        onAddFoul: () => _handleAddFoul('B'),
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Reset & Share Buttons
                  Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      AnimatedButton(
                          label: "Reset",
                          onPressed: resetAll,
                          color: colors.primary),
                      AnimatedButton(
                          label: "Share Score",
                          onPressed: shareScore,
                          color: isDark
                              ? colors.secondaryContainer
                              : colors.secondary),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // History Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isDark
                            ? colors.primary // أزرق من الثيم الداكن
                            : Colors.brown, // بني في الثيم الفاتح
                        width: 2,
                      ),
                    ),
                    elevation: isDark ? 4 : 6,
                    shadowColor: isDark
                        ? colors.primary.withOpacity(0.6)
                        : Colors.brown.withOpacity(0.5),
                    color: isDark ? colors.surfaceVariant : theme.cardColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? colors.primary
                                    .withOpacity(0.3) // نور أزرق في الداكن
                                : Colors.brown
                                    .withOpacity(0.25), // نور بني في الفاتح
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'History',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 6),
                                    child: Text(history[index],
                                        style: theme.textTheme.bodyMedium),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
