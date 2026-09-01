import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_shell.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final row = !context.isMobile;

    final headingRich = RichText(
      text: TextSpan(
        style: AppType.headlineLg(compact: context.isMobile),
        children: [
          const TextSpan(text: 'Building for the '),
          TextSpan(
            text: 'Future',
            style: AppType.headlineLg(compact: context.isMobile).copyWith(
              color: AppColors.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );

    final card = GlassCard(
      interactive: false,
      padding: EdgeInsets.all(context.isMobile ? 24 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in PortfolioData.aboutParagraphs) ...[
            Text(p, style: AppType.bodyLg),
            if (p != PortfolioData.aboutParagraphs.last)
              const SizedBox(height: 20),
          ],
          const SizedBox(height: 40),
          const Divider(color: AppColors.outlineVariant, height: 1),
          const SizedBox(height: 32),
          _StatGrid(stats: PortfolioData.stats),
        ],
      ),
    );

    return SectionShell(
      background: AppColors.surfaceContainerLow,
      child: row
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: headingRich),
                const SizedBox(width: 48),
                Expanded(flex: 3, child: card),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [headingRich, const SizedBox(height: 28), card],
            ),
    );
  }
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.stats});
  final List<Stat> stats;

  @override
  Widget build(BuildContext context) {
    final columns = context.responsive<int>(mobile: 2, desktop: 4);
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 20.0;
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: 24,
          children: [
            for (final s in stats)
              SizedBox(
                width: itemWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.value,
                      style: AppType.headlineLg().copyWith(fontSize: 32),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s.label,
                      style: AppType.labelCaps.copyWith(color: AppColors.outline),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
