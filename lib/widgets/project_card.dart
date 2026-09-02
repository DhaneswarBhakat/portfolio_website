import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'glass_card.dart';
import 'tech_chip.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    this.compact = false,
    this.banner = false,
  });

  final Project project;
  final bool compact;

  /// Prepend a gradient header strip with the project icon (Stitch mobile style).
  final bool banner;

  @override
  Widget build(BuildContext context) {
    final pad = compact ? 22.0 : 30.0;

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!banner)
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
        if (!banner) SizedBox(height: compact ? 16 : 22),
        Row(
          children: [
            Expanded(
              child: Text(
                project.name,
                style: AppType.headlineMd.copyWith(fontSize: compact ? 18 : 22),
              ),
            ),
            if (banner && project.meta != null)
              Text(
                project.meta!,
                style: AppType.labelCaps.copyWith(color: AppColors.outline),
              ),
          ],
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
    );

    if (!banner) {
      return GlassCard(padding: EdgeInsets.all(pad), child: body);
    }

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Banner(icon: project.icon),
          Padding(padding: EdgeInsets.fromLTRB(pad, pad, pad, pad), child: body),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.18),
            AppColors.surfaceContainerHigh,
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusCard),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            bottom: -12,
            child: Icon(
              icon,
              size: 120,
              color: AppColors.primary.withValues(alpha: 0.14),
            ),
          ),
          Center(
            child: Icon(icon, size: 44, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
