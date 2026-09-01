import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/section_header.dart';
import '../widgets/section_shell.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = PortfolioData.timeline;
    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(plain: 'Professional', accent: 'Journey'),
          const SizedBox(height: 48),
          for (var i = 0; i < entries.length; i++)
            _TimelineRow(
              entry: entries[i],
              isLast: i == entries.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.entry, required this.isLast});
  final TimelineEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final dot = _Dot(filled: entry.highlight);
    final rail = _Rail(visible: !isLast);

    final head = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.title, style: AppType.headlineMd.copyWith(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          entry.place,
          style: AppType.bodyLg.copyWith(
            color: entry.highlight
                ? AppColors.primary
                : AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            entry.period,
            style: AppType.labelCaps.copyWith(letterSpacing: 2),
          ),
        ),
        const SizedBox(height: 12),
        Text(entry.detail, style: AppType.bodyMd),
      ],
    );

    if (context.isMobile) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [dot, Expanded(child: rail)]),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [head, const SizedBox(height: 12), body],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Desktop / tablet: alternating sides around a centre rail.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 48),
              child: Align(
                alignment: Alignment.topRight,
                child: DefaultTextStyle.merge(
                  textAlign: TextAlign.right,
                  child: head,
                ),
              ),
            ),
          ),
          Column(children: [dot, Expanded(child: rail)]),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 48, bottom: isLast ? 0 : 56),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.filled});
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.primary : AppColors.surfaceContainer,
        border: Border.all(
          color: filled ? AppColors.primary : AppColors.outlineVariant,
          width: 2,
        ),
        boxShadow: filled
            ? [BoxShadow(color: AppColors.glow, blurRadius: 12)]
            : null,
      ),
    );
  }
}

class _Rail extends StatelessWidget {
  const _Rail({required this.visible});
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: visible
          ? AppColors.outlineVariant.withValues(alpha: 0.4)
          : Colors.transparent,
    );
  }
}
