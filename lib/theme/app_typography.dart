import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Type scale from the "Kinetic Logic" design system.
/// Inter for UI / editorial text, JetBrains Mono for labels and code.
abstract final class AppType {
  static TextStyle _inter({
    required double size,
    required FontWeight weight,
    double height = 1.6,
    double letterSpacing = 0,
    Color color = AppColors.onSurface,
  }) => GoogleFonts.inter(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );

  static TextStyle _mono({
    required double size,
    required FontWeight weight,
    double height = 1.5,
    double letterSpacing = 0,
    Color color = AppColors.onSurface,
  }) => GoogleFonts.jetBrainsMono(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );

  // Display / headings
  static TextStyle headlineXl({bool compact = false}) => _inter(
    size: compact ? 38 : 64,
    weight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static TextStyle headlineLg({bool compact = false}) => _inter(
    size: compact ? 30 : 40,
    weight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.6,
  );

  static TextStyle get headlineMd =>
      _inter(size: 24, weight: FontWeight.w600, height: 1.4);

  // Body
  static TextStyle get bodyLg => _inter(
    size: 18,
    weight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle get bodyMd => _inter(
    size: 16,
    weight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  // Mono
  static TextStyle get codeSm => _mono(
    size: 14,
    weight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle get labelCaps => _mono(
    size: 12,
    weight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 1.2,
    color: AppColors.onSurfaceVariant,
  );
}
