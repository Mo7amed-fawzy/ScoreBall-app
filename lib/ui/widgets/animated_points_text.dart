import 'package:flutter/material.dart';

class AnimatedPointsText extends StatefulWidget {
  final int points;
  const AnimatedPointsText({super.key, required this.points});

  @override
  State<AnimatedPointsText> createState() => _AnimatedPointsTextState();
}

class _AnimatedPointsTextState extends State<AnimatedPointsText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedPointsText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.points != widget.points) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Text(
        '${widget.points}',
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width < 600 ? 100 : 150,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
