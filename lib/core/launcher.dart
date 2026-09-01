import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';

/// Thin wrapper around url_launcher with a consistent "coming soon" fallback
/// so the UI never has dead links while [AppLinks] TODOs are unfilled.
abstract final class Launcher {
  static void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surfaceContainerHigh,
          content: Text(message, style: const TextStyle(color: AppColors.onSurface)),
        ),
      );
  }

  static Future<void> open(
    BuildContext context,
    String url, {
    String comingSoonMessage = 'Link coming soon',
  }) async {
    if (url.isEmpty) {
      _toast(context, comingSoonMessage);
      return;
    }
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) _toast(context, 'Could not open $url');
  }

  static Future<void> email(
    BuildContext context,
    String address, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: address,
      query: [
        if (subject != null) 'subject=${Uri.encodeComponent(subject)}',
        if (body != null) 'body=${Uri.encodeComponent(body)}',
      ].join('&'),
    );
    final ok = await launchUrl(uri);
    if (!ok && context.mounted) _toast(context, 'No mail app available — $address');
  }

  static Future<void> phone(BuildContext context, String number) async {
    final ok = await launchUrl(Uri(scheme: 'tel', path: number));
    if (!ok && context.mounted) _toast(context, number);
  }
}
