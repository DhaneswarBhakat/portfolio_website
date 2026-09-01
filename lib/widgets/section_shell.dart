import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../theme/app_spacing.dart';

/// Centers content in a max-width column with responsive side padding and a
/// consistent vertical rhythm between sections. [background] optionally tints
/// the full-bleed band behind the column.
class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.child,
    this.background,
    this.topPadding,
    this.bottomPadding,
  });

  final Widget child;
  final Color? background;
  final double? topPadding;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    final v = context.sectionSpacing;
    return Container(
      width: double.infinity,
      color: background,
      padding: EdgeInsets.fromLTRB(
        context.pagePadding,
        topPadding ?? v,
        context.pagePadding,
        bottomPadding ?? v,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.containerMax),
          child: child,
        ),
      ),
    );
  }
}
