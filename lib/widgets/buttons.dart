import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Solid primary call-to-action. Glows and swaps to a gradient on hover.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.muted = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  /// Renders greyed-out (used when a target link is not yet configured).
  final bool muted;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final muted = widget.muted;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
            gradient: muted
                ? null
                : LinearGradient(
                    colors: _hovered
                        ? const [AppColors.primaryContainer, AppColors.primary]
                        : const [AppColors.primary, AppColors.primary],
                  ),
            color: muted ? AppColors.surfaceContainerHigh : null,
            boxShadow: (_hovered && !muted)
                ? [BoxShadow(color: AppColors.glow, blurRadius: 30, spreadRadius: -4)]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppType.labelCaps.copyWith(
                  color: muted ? AppColors.onSurfaceVariant : AppColors.onPrimary,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  widget.icon,
                  size: 18,
                  color: muted ? AppColors.onSurfaceVariant : AppColors.onPrimary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined secondary action.
class GhostButton extends StatefulWidget {
  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _hovered ? AppColors.primary : AppColors.onSurface;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.outlineVariant,
            ),
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.05)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label, style: AppType.labelCaps.copyWith(color: color)),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: 18, color: color),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
