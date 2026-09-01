import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'theme/app_theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhaneswar Bhakat — Mobile Application Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      scrollBehavior: const _AppScrollBehavior(),
      home: const HomePage(),
    );
  }
}

/// Allow click-drag scrolling (useful on desktop web) alongside wheel/touch.
class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
