import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/app_links.dart';
import '../core/launcher.dart';
import '../core/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../data/portfolio_data.dart';

class NavItem {
  const NavItem(this.label, this.id);
  final String label;
  final String id;
}

const navItems = [
  NavItem('About', 'about'),
  NavItem('Skills', 'skills'),
  NavItem('Projects', 'projects'),
  NavItem('Experience', 'experience'),
  NavItem('Contact', 'contact'),
];

/// Fixed, glass-blurred top bar. Desktop shows inline links + "Hire Me".
/// Phones show a minimal brand + monogram bar; navigation there lives in the
/// [MobileBottomNav].
class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.onNavigate, required this.activeId});

  final void Function(String id) onNavigate;
  final String? activeId;

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer.withValues(alpha: 0.7),
            border: const Border(
              bottom: BorderSide(color: AppColors.cardBorder),
            ),
          ),
          child: SizedBox(
            height: AppSpacing.navHeight,
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: AppSpacing.containerMax),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.pagePadding),
                  child: Row(
                    children: [
                      _Brand(onTap: () => onNavigate('top')),
                      const Spacer(),
                      if (!compact) ...[
                        for (final item in navItems)
                          _NavLink(
                            item: item,
                            active: activeId == item.id,
                            onTap: () => onNavigate(item.id),
                          ),
                        const SizedBox(width: 12),
                        _HireMe(),
                      ] else
                        const _Monogram(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo.jpg',
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${PortfolioData.firstName} ${PortfolioData.lastName}',
              style: AppType.headlineMd.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small "DB" monogram bubble shown at the right of the mobile header.
class _Monogram extends StatelessWidget {
  const _Monogram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceContainerHigh,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
      ),
      child: Text(
        'DB',
        style: AppType.labelCaps.copyWith(
          color: AppColors.primary,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.item, required this.active, required this.onTap});
  final NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlight = widget.active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.item.label,
            style: AppType.labelCaps.copyWith(
              color: highlight ? AppColors.primary : AppColors.onSurfaceVariant,
              fontWeight: widget.active ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _HireMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Launcher.email(
          context,
          AppLinks.email,
          subject: 'Opportunity for Dhaneswar Bhakat',
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
          ),
          child: Text(
            'Hire Me',
            style: AppType.labelCaps.copyWith(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
