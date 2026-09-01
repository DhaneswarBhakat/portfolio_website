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

/// Fixed, glass-blurred top bar. Desktop shows inline links + "Hire Me";
/// narrow layouts collapse to a toggle that expands a dropdown panel.
class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.onNavigate, required this.activeId});

  final void Function(String id) onNavigate;
  final String? activeId;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _menuOpen = false;

  void _go(String id) {
    setState(() => _menuOpen = false);
    widget.onNavigate(id);
  }

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
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
                          _Brand(onTap: () => _go('top')),
                          const Spacer(),
                          if (!compact) ...[
                            for (final item in navItems)
                              _NavLink(
                                item: item,
                                active: widget.activeId == item.id,
                                onTap: () => _go(item.id),
                              ),
                            const SizedBox(width: 12),
                            _HireMe(),
                          ] else
                            IconButton(
                              onPressed: () =>
                                  setState(() => _menuOpen = !_menuOpen),
                              icon: Icon(
                                _menuOpen ? Icons.close : Icons.menu,
                                color: AppColors.onSurface,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (compact)
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  crossFadeState: _menuOpen
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: _MobileMenu(
                    activeId: widget.activeId,
                    onTap: _go,
                  ),
                  secondChild: const SizedBox(width: double.infinity),
                ),
            ],
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

class _MobileMenu extends StatelessWidget {
  const _MobileMenu({required this.activeId, required this.onTap});
  final String? activeId;
  final void Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        context.pagePadding,
        8,
        context.pagePadding,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final item in navItems)
            TextButton(
              onPressed: () => onTap(item.id),
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                item.label,
                style: AppType.labelCaps.copyWith(
                  color: activeId == item.id
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
