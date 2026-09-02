import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Two-tone heading (`plain` + italic accent word) with a divider rule, matching
/// the Stitch section titles. [ruleLeading] puts the rule before the text.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.plain,
    required this.accent,
    this.ruleLeading = false,
    this.mobileIcon,
    this.mobileLabel,
  });

  final String plain;
  final String accent;
  final bool ruleLeading;

  /// On phones the Stitch layout uses a compact `icon + short label` header.
  final IconData? mobileIcon;
  final String? mobileLabel;

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final rule = Expanded(
      child: Container(
        height: 1,
        color: AppColors.outlineVariant.withValues(alpha: 0.3),
      ),
    );

    final title = RichText(
      text: TextSpan(
        style: AppType.headlineLg(compact: compact),
        children: [
          TextSpan(text: '$plain '),
          TextSpan(
            text: accent,
            style: AppType.headlineLg(compact: compact).copyWith(
              color: AppColors.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );

    // Phones: compact icon + label header per the Stitch mobile design.
    if (context.isMobile) {
      if (mobileIcon == null && mobileLabel == null) return title;
      return Row(
        children: [
          if (mobileIcon != null) ...[
            Icon(mobileIcon, color: AppColors.primary, size: 22),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Text(
              mobileLabel ?? '$plain $accent',
              style: AppType.headlineMd,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        if (ruleLeading) ...[rule, const SizedBox(width: 16)],
        Flexible(child: title),
        if (!ruleLeading) ...[const SizedBox(width: 16), rule],
      ],
    );
  }
}

/// Small uppercase mono kicker, e.g. "// 02 — Skills".
class SectionKicker extends StatelessWidget {
  const SectionKicker(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppType.labelCaps.copyWith(
        color: AppColors.primary,
        letterSpacing: 2,
      ),
    );
  }
}
