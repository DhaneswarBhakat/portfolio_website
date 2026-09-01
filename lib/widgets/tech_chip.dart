import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Small monospace pill used for tech-stack tags.
class TechChip extends StatelessWidget {
  const TechChip(this.label, {super.key, this.accent = false});

  final String label;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent
            ? AppColors.primary.withValues(alpha: 0.10)
            : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border: Border.all(
          color: accent
              ? AppColors.primary.withValues(alpha: 0.35)
              : AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: AppType.codeSm.copyWith(
          color: accent ? AppColors.primary : AppColors.onSurfaceVariant,
          height: 1.1,
        ),
      ),
    );
  }
}

/// Rounded, larger variant used in the Skills section.
class SkillPill extends StatelessWidget {
  const SkillPill(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Text(label, style: AppType.bodyMd),
    );
  }
}
