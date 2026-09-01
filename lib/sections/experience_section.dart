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
              isFirst: i == 0,
              isLast: i == entries.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  final TimelineEntry entry;
  final bool isFirst;
  final bool isLast;

  static const double _dotSize = 16;
  static const double _dotTop = 4;

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final gap = isLast ? 0.0 : (mobile ? 44.0 : 56.0);

    final head = Column(
      crossAxisAlignment:
          mobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          entry.title,
          textAlign: mobile ? TextAlign.start : TextAlign.end,
          style: AppType.headlineMd.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          entry.place,
          textAlign: mobile ? TextAlign.start : TextAlign.end,
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
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
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
        ),
        const SizedBox(height: 12),
        Text(entry.detail, style: AppType.bodyMd),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // x of the connector line / dot centre.
        final centreX = mobile ? _dotSize / 2 : width / 2;

        final Widget content;
        if (mobile) {
          content = Padding(
            padding: EdgeInsets.only(left: _dotSize + 20, bottom: gap),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [head, const SizedBox(height: 12), body],
            ),
          );
        } else {
          content = Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 48),
                    child: head,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: body,
                  ),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            content,
            // Connector line: spans the full row, trimmed at the ends.
            Positioned(
              left: centreX - 0.5,
              width: 1,
              top: isFirst ? _dotTop + _dotSize / 2 : 0,
              bottom: isLast ? null : 0,
              height: isLast ? _dotTop + _dotSize / 2 : null,
              child: const ColoredBox(color: Color(0x66424754)),
            ),
            // Dot.
            Positioned(
              left: centreX - _dotSize / 2,
              top: _dotTop,
              child: _Dot(filled: entry.highlight),
            ),
          ],
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.filled});
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _TimelineRow._dotSize,
      height: _TimelineRow._dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.primary : AppColors.surfaceContainer,
        border: Border.all(
          color: filled ? AppColors.primary : AppColors.outlineVariant,
          width: 2,
        ),
        boxShadow:
            filled ? [BoxShadow(color: AppColors.glow, blurRadius: 12)] : null,
      ),
    );
  }
}
