import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_links.dart';
import '../core/launcher.dart';
import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/buttons.dart';
import '../widgets/section_shell.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final stacked = !context.isDesktop;

    final text = _HeroText(onViewProjects: onViewProjects);
    const avatar = _HeroAvatar();

    return SectionShell(
      topPadding: AppSpacing.navHeight + (context.isMobile ? 48 : 96),
      bottomPadding: context.sectionSpacing,
      child: stacked
          ? Column(
              children: [
                const Align(alignment: Alignment.center, child: avatar),
                const SizedBox(height: 48),
                text,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 7, child: text),
                const SizedBox(width: 48),
                const Expanded(flex: 5, child: Center(child: avatar)),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.onViewProjects});
  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final crossAxis =
        context.isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final align = context.isDesktop ? TextAlign.start : TextAlign.center;

    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Text(
          "HELLO, I'M",
          style: AppType.labelCaps.copyWith(
            color: AppColors.primary,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: align,
          text: TextSpan(
            style: AppType.headlineXl(compact: compact),
            children: [
              TextSpan(text: '${PortfolioData.firstName}\n'),
              TextSpan(
                text: '${PortfolioData.lastName}.',
                style: AppType.headlineXl(compact: compact).copyWith(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryContainer],
                    ).createShader(const Rect.fromLTWH(0, 0, 400, 80)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          PortfolioData.role,
          textAlign: align,
          style: AppType.headlineMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            PortfolioData.heroTagline,
            textAlign: align,
            style: AppType.bodyLg.copyWith(color: AppColors.outline),
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            PrimaryButton(
              label: 'View Projects',
              icon: Icons.arrow_forward,
              onPressed: onViewProjects,
            ),
            GhostButton(
              label: 'Download Résumé',
              icon: Icons.download,
              onPressed: () => Launcher.open(
                context,
                AppLinks.resumeUrl,
                comingSoonMessage: 'Résumé link coming soon',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroAvatar extends StatefulWidget {
  const _HeroAvatar();

  @override
  State<_HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<_HeroAvatar>
    with TickerProviderStateMixin {
  late final AnimationController _outer =
      AnimationController(vsync: this, duration: const Duration(seconds: 24))
        ..repeat();
  late final AnimationController _inner =
      AnimationController(vsync: this, duration: const Duration(seconds: 32))
        ..repeat();

  @override
  void dispose() {
    _outer.dispose();
    _inner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.responsive<double>(
      mobile: 240,
      tablet: 300,
      desktop: 380,
    );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring: a bright arc + node sweeps around as it rotates.
          RotationTransition(
            turns: _outer,
            child: CustomPaint(
              size: Size.square(size),
              painter: _SweepRingPainter(),
            ),
          ),
          // Inner ring: dashed, counter-rotating.
          Padding(
            padding: const EdgeInsets.all(18),
            child: RotationTransition(
              turns: Tween<double>(begin: 1, end: 0).animate(_inner),
              child: CustomPaint(
                size: Size.square(size - 36),
                painter: _DashedRingPainter(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(size * 0.12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [AppColors.surfaceContainerHigh, AppColors.surfaceContainerLowest],
              ),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(color: AppColors.glow, blurRadius: 40, spreadRadius: -8),
              ],
            ),
            child: Center(
              child: Text(
                'DB',
                style: AppType.headlineXl().copyWith(
                  fontSize: size * 0.28,
                  fontFamily: AppType.codeSm.fontFamily,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          Positioned(
            top: size * 0.12,
            left: 0,
            child: _Floater('Flutter', color: AppColors.primary),
          ),
          Positioned(
            bottom: size * 0.16,
            right: 0,
            child: _Floater('Kotlin', color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}

class _Floater extends StatelessWidget {
  const _Floater(this.label, {required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Text(label, style: AppType.codeSm.copyWith(color: color)),
    );
  }
}

/// Thin circle stroke with a sweep-gradient arc and a glowing node, so rotation
/// reads as motion (a plain circle looks identical at every angle).
class _SweepRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2 - 1;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = AppColors.primary.withValues(alpha: 0.12),
    );

    final sweep = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0),
          AppColors.primary.withValues(alpha: 0.9),
        ],
        stops: const [0.0, 1.0],
        startAngle: 0,
        endAngle: math.pi * 0.8,
      ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 0.8,
      false,
      sweep,
    );

    // Glowing node at the leading end of the arc (top of the unrotated ring).
    final node = Offset(center.dx, center.dy - radius);
    canvas.drawCircle(
      node,
      3.5,
      Paint()
        ..color = AppColors.primary
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(node, 2.5, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Dashed circle stroke — the dashes make the counter-rotation visible.
class _DashedRingPainter extends CustomPainter {
  static const int _dashes = 44;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final radius = size.width / 2 - 1;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = AppColors.outlineVariant;

    final step = (2 * math.pi) / _dashes;
    final dash = step * 0.5;
    final oval = Rect.fromCircle(center: center, radius: radius);
    for (var i = 0; i < _dashes; i++) {
      canvas.drawArc(oval, i * step, dash, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
