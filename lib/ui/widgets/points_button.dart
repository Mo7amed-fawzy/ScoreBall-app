import 'package:flutter/material.dart';

class PointsButton extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onPressed;

  const PointsButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: isMobile ? 8 : 12, horizontal: 16),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size(isMobile ? 120 : 150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => onPressed(value),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
