import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Fixed glass tab bar shown on phones instead of the desktop nav links,
/// matching the Stitch mobile design.
class MobileBottomNav extends StatelessWidget {
  const MobileBottomNav({
    super.key,
    required this.onNavigate,
    required this.activeId,
  });

  final void Function(String id) onNavigate;
  final String? activeId;

  static const _items = <({String id, IconData icon, String label})>[
    (id: 'top', icon: Icons.home_outlined, label: 'Home'),
    (id: 'skills', icon: Icons.token_outlined, label: 'Stack'),
    (id: 'projects', icon: Icons.code, label: 'Builds'),
    (id: 'experience', icon: Icons.timeline_outlined, label: 'Journey'),
    (id: 'contact', icon: Icons.alternate_email, label: 'Connect'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer.withValues(alpha: 0.75),
            border: const Border(top: BorderSide(color: AppColors.cardBorder)),
          ),
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (final item in _items)
                  _Tab(
                    icon: item.icon,
                    label: item.label,
                    active: activeId == item.id ||
                        (item.id == 'top' && activeId == null),
                    onTap: () => onNavigate(item.id),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        active ? AppColors.primary : AppColors.onSurfaceVariant;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              style: AppType.labelCaps
                  .copyWith(color: color, fontSize: 10, letterSpacing: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
