import 'package:flutter/material.dart';

/// Palette from the Stitch "Kinetic Logic" design system — a dark, "deep space"
/// scheme with an electric-blue accent.
abstract final class AppColors {
  // Surfaces
  static const background = Color(0xFF0F131D);
  static const surface = Color(0xFF0F131D);
  static const surfaceContainerLowest = Color(0xFF0A0E18);
  static const surfaceContainerLow = Color(0xFF171B26);
  static const surfaceContainer = Color(0xFF1C1F2A);
  static const surfaceContainerHigh = Color(0xFF262A35);
  static const surfaceContainerHighest = Color(0xFF313540);

  // Accent
  static const primary = Color(0xFFADC6FF);
  static const primaryContainer = Color(0xFF4D8EFF);
  static const onPrimary = Color(0xFF002E6A);

  // Text
  static const onSurface = Color(0xFFDFE2F1);
  static const onSurfaceVariant = Color(0xFFC2C6D6);
  static const outline = Color(0xFF8C909F);
  static const outlineVariant = Color(0xFF424754);

  // Secondary accents
  static const tertiary = Color(0xFFFFB786);
  static const error = Color(0xFFFFB4AB);

  // Effects
  static const glassFill = Color(0xB31C1F2A); // surfaceContainer @ 70%
  static const cardBorder = Color(0x1FFFFFFF); // white @ ~12%
  static const cardBorderHover = Color(0x66ADC6FF); // primary @ 40%
  static Color get glow => primary.withValues(alpha: 0.25);
}
