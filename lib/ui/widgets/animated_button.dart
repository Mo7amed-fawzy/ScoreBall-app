import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const AnimatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      child: Transform.scale(
        scale: scale,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            backgroundColor: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.black45,
            elevation: 6,
          ),
          onPressed: widget.onPressed,
          child: Text(widget.label,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }
}
