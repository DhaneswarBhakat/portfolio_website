import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Translucent, blurred surface with a hairline border — the primary container
/// style from the design system. Hovering lifts it and warms the border to
/// primary with a soft glow.
class GlassCard extends StatefulWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.interactive = true,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool interactive;
  final VoidCallback? onTap;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  void _setHover(bool value) {
    if (widget.interactive && _hovered != value) {
      setState(() => _hovered = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lifted = _hovered && widget.interactive;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, lifted ? -4 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(
              color: lifted ? AppColors.cardBorderHover : AppColors.cardBorder,
            ),
            boxShadow: lifted
                ? [BoxShadow(color: AppColors.glow, blurRadius: 24, spreadRadius: -6)]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                padding: widget.padding,
                color: AppColors.glassFill,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
