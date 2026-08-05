import 'package:flutter/material.dart';

class SplashLoading extends StatefulWidget {
  const SplashLoading({
    super.key,
    this.color = Colors.white,
    this.dotSize = 8,
    this.spacing = 10,
  });

  final Color color;
  final double dotSize;
  final double spacing;

  @override
  State<SplashLoading> createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<SplashLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _opacity(int index) {
    final value = (_controller.value + index * .2) % 1;

    if (value < .33) {
      return .35;
    }

    if (value < .66) {
      return .70;
    }

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
              child: Container(
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: widget.color.withValues(
                    alpha: _opacity(index),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}