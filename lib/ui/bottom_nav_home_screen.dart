import 'package:basketball_counter_app/ui/points_counter.dart';
import 'package:basketball_counter_app/ui/score_board_screen.dart';
import 'package:flutter/material.dart';

class BottomNavHomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;
  final int currentIndex;
  final void Function(int) setIndex;
  final VoidCallback openScoreBoardTab;

  const BottomNavHomeScreen({
    super.key,
    required this.isDark,
    required this.toggleTheme,
    required this.currentIndex,
    required this.setIndex,
    required this.openScoreBoardTab,
  });

  @override
  State<BottomNavHomeScreen> createState() => _BottomNavHomeScreenState();
}

class _BottomNavHomeScreenState extends State<BottomNavHomeScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.currentIndex;
  }

  void _onTap(int i) {
    setState(() => index = i);
    widget.setIndex(i);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      PointsCounterScreen(
        isDark: widget.isDark,
        toggleTheme: widget.toggleTheme,
      ),
      ScoreBoardScreen(isDark: widget.isDark),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Counter'),
          BottomNavigationBarItem(icon: Icon(Icons.score), label: 'ScoreBoard'),
        ],
      ),
    );
  }
}
