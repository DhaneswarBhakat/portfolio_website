import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'glass_card.dart';
import 'tech_chip.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project, this.compact = false});

  final Project project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(compact ? 22 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                project.icon,
                size: compact ? 26 : 34,
                color: AppColors.primary,
              ),
              const Spacer(),
              if (project.meta != null)
                Text(
                  project.meta!,
                  style: AppType.labelCaps.copyWith(color: AppColors.outline),
                ),
            ],
          ),
          SizedBox(height: compact ? 16 : 22),
          Text(
            project.name,
            style: AppType.headlineMd.copyWith(fontSize: compact ? 18 : 22),
          ),
          if (project.subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              project.subtitle!,
              style: AppType.labelCaps.copyWith(color: AppColors.primary),
            ),
          ],
          SizedBox(height: compact ? 12 : 16),
          Text(
            project.summary,
            style: (compact ? AppType.bodyMd : AppType.bodyLg).copyWith(
              fontSize: compact ? 14.5 : 16,
              height: 1.6,
            ),
          ),
          SizedBox(height: compact ? 18 : 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < project.tags.length; i++)
                TechChip(project.tags[i], accent: i == 0),
            ],
          ),
        ],
      ),
    );
  }
}
