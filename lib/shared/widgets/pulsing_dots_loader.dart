import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A row of softly blinking dots used as a lightweight loading
/// indicator — matches the source splash screen's `dot-blink` loader.
///
/// Each dot's opacity oscillates on its own phase offset, producing a
/// staggered "breathing" effect rather than all dots blinking in
/// unison.
class PulsingDotsLoader extends StatefulWidget {
  const PulsingDotsLoader({
    super.key,
    this.color,
    this.dotCount = 3,
    this.dotSize = 5,
    this.spacing = 5,
    this.duration = const Duration(milliseconds: 1200),
  });

  /// Dot color. Defaults to a semi-transparent white, matching the
  /// source splash screen's loader on a dark gradient background.
  final Color? color;

  /// Number of dots to render.
  final int dotCount;

  /// Diameter of each dot.
  final double dotSize;

  /// Horizontal gap between dots.
  final double spacing;

  /// Duration of one full blink cycle per dot.
  final Duration duration;

  @override
  State<PulsingDotsLoader> createState() => _PulsingDotsLoaderState();
}

class _PulsingDotsLoaderState extends State<PulsingDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = widget.color ?? Colors.white.withValues(alpha: 0.5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.dotCount, (index) {
        final phaseOffset = widget.dotCount == 0 ? 0.0 : index / widget.dotCount;

        return Padding(
          padding: EdgeInsets.only(
            right: index == widget.dotCount - 1 ? 0 : widget.spacing,
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = (_controller.value + phaseOffset) % 1.0;
              // Mirrors the CSS `dot-blink` keyframes: 1 -> 0.3 -> 1.
              final opacity = 0.3 + 0.7 * (0.5 + 0.5 * math.cos(2 * math.pi * t));
              return Opacity(opacity: opacity, child: child);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              child: SizedBox(width: widget.dotSize, height: widget.dotSize),
            ),
          ),
        );
      }),
    );
  }
}