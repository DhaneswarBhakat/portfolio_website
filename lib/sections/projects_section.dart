import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/project_card.dart';
import '../widgets/section_header.dart';
import '../widgets/section_shell.dart';

/// Featured production work + a denser "Labs" grid of personal projects.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return SectionShell(
      background: AppColors.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            plain: 'Featured',
            accent: 'Projects',
            ruleLeading: true,
            mobileIcon: Icons.widgets_outlined,
            mobileLabel: 'Builds',
          ),
          SizedBox(height: mobile ? 20 : 40),
          _Grid(
            columns: context.responsive(mobile: 1, desktop: 2),
            children: [
              for (final p in PortfolioData.featuredProjects)
                ProjectCard(project: p, banner: mobile),
            ],
          ),
          SizedBox(height: context.sectionSpacing * 0.6),
          const _LabsHeader(),
          const SizedBox(height: 8),
          Text(
            'Side projects and experiments built to try out an idea, an API or a design.',
            style: AppType.bodyMd,
          ),
          SizedBox(height: mobile ? 20 : 32),
          _Grid(
            columns: context.responsive(mobile: 1, tablet: 2, desktop: 3),
            gap: 20,
            children: [
              for (final p in PortfolioData.personalProjects)
                ProjectCard(project: p, compact: true, banner: mobile),
            ],
          ),
        ],
      ),
    );
  }
}

class _LabsHeader extends StatelessWidget {
  const _LabsHeader();

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const SectionHeader(
        plain: 'Labs &',
        accent: 'Experiments',
        mobileIcon: Icons.science_outlined,
        mobileLabel: 'Labs & Experiments',
      );
    }
    return RichText(
      text: TextSpan(
        style: AppType.headlineLg(),
        children: [
          const TextSpan(text: 'Labs & '),
          TextSpan(
            text: 'Experiments',
            style: AppType.headlineLg().copyWith(
              color: AppColors.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.columns, required this.children, this.gap = 24});

  final int columns;
  final double gap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (columns == 1) {
          return Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1) SizedBox(height: gap),
              ],
            ],
          );
        }
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}
