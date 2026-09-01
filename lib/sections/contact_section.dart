import 'package:flutter/material.dart';

import '../core/app_links.dart';
import '../core/launcher.dart';
import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/buttons.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_shell.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final row = context.isDesktop;
    const left = _ContactDetails();
    const right = _ContactForm();

    return SectionShell(
      background: AppColors.surfaceContainerLow,
      child: row
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: left),
                SizedBox(width: 64),
                Expanded(child: right),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, const SizedBox(height: 40), right],
            ),
    );
  }
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppType.headlineXl(compact: context.isMobile).copyWith(
              fontSize: context.isMobile ? 36 : 48,
            ),
            children: [
              const TextSpan(text: "Let's "),
              TextSpan(
                text: 'Connect',
                style: AppType.headlineXl(compact: context.isMobile)
                    .copyWith(
                      fontSize: context.isMobile ? 36 : 48,
                      color: AppColors.primary,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Text(PortfolioData.contactBlurb, style: AppType.bodyLg),
        ),
        const SizedBox(height: 36),
        _ContactRow(
          icon: Icons.mail_outline,
          label: 'EMAIL',
          value: AppLinks.email,
          onTap: () => Launcher.email(context, AppLinks.email),
        ),
        const SizedBox(height: 20),
        _ContactRow(
          icon: Icons.call_outlined,
          label: 'PHONE',
          value: '+91 88639 48549',
          onTap: () => Launcher.phone(context, AppLinks.phone),
        ),
        const SizedBox(height: 20),
        _ContactRow(
          icon: Icons.code,
          label: 'GITHUB',
          value: AppLinks.hasGithub
              ? AppLinks.pretty(AppLinks.githubUrl)
              : 'Add link soon',
          muted: !AppLinks.hasGithub,
          onTap: () => Launcher.open(
            context,
            AppLinks.githubUrl,
            comingSoonMessage: 'GitHub link coming soon',
          ),
        ),
        const SizedBox(height: 20),
        _ContactRow(
          icon: Icons.group_outlined,
          label: 'LINKEDIN',
          value: AppLinks.hasLinkedin
              ? AppLinks.pretty(AppLinks.linkedinUrl)
              : 'Add link soon',
          muted: !AppLinks.hasLinkedin,
          onTap: () => Launcher.open(
            context,
            AppLinks.linkedinUrl,
            comingSoonMessage: 'LinkedIn link coming soon',
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.muted = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final color = muted ? AppColors.outline : AppColors.onSurface;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceContainer,
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(icon, size: 22, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppType.labelCaps.copyWith(
                    color: AppColors.outline,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: AppType.bodyLg.copyWith(color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  void _send() {
    final body = StringBuffer()
      ..writeln('From: ${_name.text} <${_email.text}>')
      ..writeln()
      ..writeln(_message.text);
    Launcher.email(
      context,
      AppLinks.email,
      subject: 'Portfolio enquiry from ${_name.text.isEmpty ? 'website' : _name.text}',
      body: body.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      interactive: false,
      padding: EdgeInsets.all(context.isMobile ? 24 : 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Field(label: 'Name', controller: _name, hint: 'Jane Doe'),
          const SizedBox(height: 20),
          _Field(
            label: 'Email',
            controller: _email,
            hint: 'jane@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _Field(
            label: 'Message',
            controller: _message,
            hint: 'How can we work together?',
            maxLines: 5,
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Send Message',
            icon: Icons.send,
            onPressed: _send,
          ),
          const SizedBox(height: 12),
          Text(
            'Opens your mail app addressed to ${AppLinks.email}.',
            style: AppType.codeSm.copyWith(color: AppColors.outline),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppType.labelCaps.copyWith(letterSpacing: 2),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: AppType.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppType.bodyMd.copyWith(
              color: AppColors.outline.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
