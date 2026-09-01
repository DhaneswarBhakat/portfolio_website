import 'package:flutter/material.dart';

import '../core/app_links.dart';
import '../core/launcher.dart';
import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            'assets/images/logo.jpg',
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${PortfolioData.firstName} ${PortfolioData.lastName} — ${PortfolioData.role}',
          style: AppType.labelCaps.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );

    final links = Wrap(
      spacing: 24,
      runSpacing: 12,
      children: [
        _FooterLink(
          icon: Icons.mail_outline,
          label: 'Email',
          onTap: () => Launcher.email(context, AppLinks.email),
        ),
        _FooterLink(
          icon: Icons.code,
          label: 'GitHub',
          onTap: () => Launcher.open(
            context,
            AppLinks.githubUrl,
            comingSoonMessage: 'GitHub link coming soon',
          ),
        ),
        _FooterLink(
          icon: Icons.group_outlined,
          label: 'LinkedIn',
          onTap: () => Launcher.open(
            context,
            AppLinks.linkedinUrl,
            comingSoonMessage: 'LinkedIn link coming soon',
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      color: AppColors.surfaceContainerLowest,
      padding: EdgeInsets.symmetric(
        horizontal: context.pagePadding,
        vertical: AppSpacing.stackLg,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.containerMax),
          child: context.isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    brand,
                    const SizedBox(height: 8),
                    _Copyright(),
                    const SizedBox(height: 20),
                    links,
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [brand, const SizedBox(height: 8), _Copyright()],
                    ),
                    links,
                  ],
                ),
        ),
      ),
    );
  }
}

class _Copyright extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '© ${DateTime.now().year} ${PortfolioData.firstName} ${PortfolioData.lastName}. '
      'Built with Flutter.',
      style: AppType.codeSm.copyWith(color: AppColors.outline),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppType.labelCaps.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
