import 'package:basketball_counter_app/core/cache_helper.dart';
import 'package:basketball_counter_app/core/service_locator.dart';
import 'package:basketball_counter_app/core/theme.dart';
import 'package:basketball_counter_app/ui/bottom_nav_home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();

  runApp(const PointsCounter());
}

/// Root App - يدير الثيم والتنقّل بين الشاشتين
class PointsCounter extends StatefulWidget {
  const PointsCounter({super.key});

  @override
  State<PointsCounter> createState() => _PointsCounterState();
}

class _PointsCounterState extends State<PointsCounter> {
  bool isDark = false;
  int currentIndex = 0;

  void toggleTheme() => setState(() => isDark = !isDark);
  void openScoreBoardTab() => setState(() => currentIndex = 1);
  void openPointsTab() => setState(() => currentIndex = 0);
  void setIndex(int idx) => setState(() => currentIndex = idx);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Tools',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: BottomNavHomeScreen(
        isDark: isDark,
        toggleTheme: toggleTheme,
        currentIndex: currentIndex,
        setIndex: setIndex,
        openScoreBoardTab: openScoreBoardTab,
      ),
    );
  }
}
