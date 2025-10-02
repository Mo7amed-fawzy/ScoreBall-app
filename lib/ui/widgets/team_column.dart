import 'package:basketball_counter_app/ui/widgets/animated_points_text.dart';
import 'package:basketball_counter_app/ui/widgets/points_button.dart';
import 'package:flutter/material.dart';

class TeamColumn extends StatelessWidget {
  final String teamName;
  final int points;
  final int fouls;
  final Function(int) onAddPoints;
  final Function() onAddFoul;
  final bool isMobile;

  const TeamColumn({
    super.key,
    required this.teamName,
    required this.points,
    required this.fouls,
    required this.onAddPoints,
    required this.onAddFoul,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isMobile ? 10 : 0,
        horizontal: isMobile ? 0 : 8,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? colorScheme.primary : Colors.brown.shade400,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                (isDark ? colorScheme.primary : Colors.brown).withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              teamName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedPointsText(points: points),
            Text(
              'Fouls: $fouls',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: isMobile ? 20 : 24,
              ),
            ),
            PointsButton(
                label: "Add 1 Point", value: 1, onPressed: onAddPoints),
            PointsButton(
                label: "Add 2 Points", value: 2, onPressed: onAddPoints),
            PointsButton(
                label: "Add 3 Points", value: 3, onPressed: onAddPoints),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
                minimumSize: Size(isMobile ? 120 : 150, 50),
              ),
              onPressed: onAddFoul,
              child: const Text('Add Foul'),
            ),
          ],
        ),
      ),
    );
  }
}
