import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades + slides its child up the first time it scrolls into view.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.id,
    required this.child,
    this.offset = 30,
    this.duration = const Duration(milliseconds: 600),
  });

  final String id;
  final Widget child;
  final double offset;
  final Duration duration;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _shown = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reveal-${widget.id}'),
      onVisibilityChanged: (info) {
        if (!_shown && info.visibleFraction > 0.08 && mounted) {
          setState(() => _shown = true);
        }
      },
      child: AnimatedSlide(
        offset: _shown ? Offset.zero : Offset(0, widget.offset / 100),
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _shown ? 1 : 0,
          duration: widget.duration,
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
