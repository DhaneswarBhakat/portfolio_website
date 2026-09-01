// Smoke test: the portfolio app boots and renders its identity + nav.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:portfolio_website/app.dart';

void main() {
  testWidgets('renders role and section nav', (tester) async {
    // Fire visibility callbacks synchronously so no timer outlives the test.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    tester.view.physicalSize = const Size(1440, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Mobile Application Developer'), findsWidgets);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);

    // Tear down the tree so repeating ring animations don't leak a ticker.
    await tester.pumpWidget(const SizedBox());
  });
}
