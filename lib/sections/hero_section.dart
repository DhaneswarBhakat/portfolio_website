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
          RotationTransition(
            turns: _outer,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
          RotationTransition(
            turns: Tween<double>(begin: 1, end: 0).animate(_inner),
            child: Container(
              margin: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.outlineVariant,
                  style: BorderStyle.solid,
                  width: 1,
                ),
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
