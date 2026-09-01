import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/section_shell.dart';
import '../widgets/tech_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = context.responsive<int>(mobile: 1, tablet: 2, desktop: 3);

    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(plain: 'Technical', accent: 'Arsenal'),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final group in PortfolioData.skillGroups)
                    SizedBox(
                      width: columns == 1 ? constraints.maxWidth : width,
                      child: _SkillCard(group: group),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.group});
  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(group.icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  group.title,
                  style: AppType.headlineMd.copyWith(fontSize: 19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [for (final s in group.skills) SkillPill(s)],
          ),
        ],
      ),
    );
  }
}
