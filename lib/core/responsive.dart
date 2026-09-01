import 'package:flutter/widgets.dart';

import '../theme/app_spacing.dart';

enum Breakpoint { mobile, tablet, desktop }

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  Breakpoint get breakpoint {
    final w = screenWidth;
    if (w < 700) return Breakpoint.mobile;
    if (w <= 1024) return Breakpoint.tablet;
    return Breakpoint.desktop;
  }

  bool get isMobile => breakpoint == Breakpoint.mobile;
  bool get isTablet => breakpoint == Breakpoint.tablet;
  bool get isDesktop => breakpoint == Breakpoint.desktop;

  /// Horizontal page padding: tighter on phones.
  double get pagePadding =>
      isMobile ? AppSpacing.marginMobile : AppSpacing.gutter;

  /// Vertical rhythm between major sections.
  double get sectionSpacing => isMobile ? AppSpacing.stackLg : AppSpacing.stackXl;

  T responsive<T>({required T mobile, T? tablet, required T desktop}) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return mobile;
      case Breakpoint.tablet:
        return tablet ?? desktop;
      case Breakpoint.desktop:
        return desktop;
    }
  }
}
