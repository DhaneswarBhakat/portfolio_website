import 'package:flutter/material.dart';

import '../models/models.dart';

/// All site copy lives here so entries can be edited without touching layout code.
abstract final class PortfolioData {
  // ---------------------------------------------------------------------------
  // Profile
  // ---------------------------------------------------------------------------
  static const String firstName = 'Dhaneswar';
  static const String lastName = 'Bhakat';
  static const String role = 'Mobile Application Developer';

  static const String heroTagline =
      'Crafting high-performance cross-platform apps with Flutter, React Native '
      'and Kotlin — clean architecture, offline-first systems, and deep hardware '
      'integration.';

  static const List<Stat> stats = [
    Stat('2.8+', 'Years Experience'),
    Stat('12+', 'Projects Shipped'),
    Stat('3', 'Platforms'),
    Stat('MCA', '+ BCA'),
  ];

  static const List<String> aboutParagraphs = [
    'With over 2.8 years of production experience in mobile development, backed '
        'by MCA & BCA degrees, I build robust, scalable applications. My approach '
        'leans on Clean Architecture and BLoC / Cubit state management to keep '
        'codebases maintainable as they grow.',
    'I care most about offline-first experiences that keep working regardless of '
        'network conditions, and about bridging software and physical hardware — '
        'thermal printers, barcode scanners, payment terminals and serial devices '
        'through platform channels and native SDKs.',
  ];

  // ---------------------------------------------------------------------------
  // Skills
  // ---------------------------------------------------------------------------
  static const List<SkillGroup> skillGroups = [
    SkillGroup(
      title: 'Languages & Frameworks',
      icon: Icons.code,
      skills: [
        'Dart',
        'Flutter',
        'Kotlin',
        'Jetpack Compose',
        'React Native',
        'JavaScript',
        'Java (Basic)',
      ],
    ),
    SkillGroup(
      title: 'iOS / Apple',
      icon: Icons.apple,
      skills: [
        'Swift',
        'SwiftUI',
        'Combine',
        'Swift Concurrency (async/await)',
        'Core Data',
        'XCTest',
        'Swift Package Manager',
        'Xcode & Instruments',
        'TestFlight',
        'App Store Connect',
        'CocoaPods',
        'Fastlane',
      ],
    ),
    SkillGroup(
      title: 'Architecture & State',
      icon: Icons.architecture,
      skills: [
        'Clean Architecture',
        'MVVM',
        'BLoC / Cubit',
        'Provider',
        'Riverpod',
        'GetX',
        'Repository Pattern',
        'DI (get_it)',
      ],
    ),
    SkillGroup(
      title: 'Backend & Data',
      icon: Icons.storage,
      skills: [
        'REST / HTTP',
        'JWT Auth',
        'WebSocket',
        'SignalR',
        'SQLite',
        'Hive',
        'SQL Server',
        'PostgreSQL',
        'Firestore',
      ],
    ),
    SkillGroup(
      title: 'Firebase & Cloud',
      icon: Icons.cloud_outlined,
      skills: [
        'Auth',
        'Cloud Messaging',
        'Crashlytics',
        'Analytics',
        'Remote Config',
        'Performance',
        'App Check',
        'Firebase AI (Gemini)',
      ],
    ),
    SkillGroup(
      title: 'Platforms',
      icon: Icons.devices,
      skills: ['Android', 'iOS', 'Windows Desktop'],
    ),
    SkillGroup(
      title: 'Integrations & Hardware',
      icon: Icons.integration_instructions_outlined,
      skills: [
        'ESC/POS Thermal Printers',
        'Barcode Scanners (ML Kit / Serial / USB)',
        'Bluetooth (flutter_blue_plus)',
        'Payment Terminal SDKs',
        'Serial Port',
        'Stripe',
        'Google Maps',
        'Platform Channels (C++/Dart)',
      ],
    ),
    SkillGroup(
      title: 'Auth',
      icon: Icons.verified_user_outlined,
      skills: [
        'Firebase Auth',
        'Google Sign-In',
        'Apple Sign-In',
        'OTP Login',
        'JWT',
      ],
    ),
    SkillGroup(
      title: 'Tooling',
      icon: Icons.build_outlined,
      skills: [
        'Git & GitHub',
        'Android Studio',
        'VS Code',
        'Gradle',
        'Postman',
        'Azure DevOps',
        'CI/CD',
        'FVM',
        'Play Store / App Store Releases',
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Featured (production) projects
  // ---------------------------------------------------------------------------
  static const List<Project> featuredProjects = [
    Project(
      name: 'BrijjWorks POS',
      subtitle: 'Point of Sale · Windows & Android',
      meta: 'RBIS Technology',
      icon: Icons.point_of_sale,
      summary:
          'Cross-platform Point-of-Sale for Windows and Android. Offline-first '
          'SQLite store with two-way REST sync so tills keep running with no '
          'network. Deep hardware integration — ESC/POS thermal printers, ML Kit '
          'plus serial/USB barcode scanners, Bluetooth peripherals and '
          'payment-terminal SDKs. Promotions & loyalty engine, multi-mode '
          'payments, inventory and customer management, live sales dashboards '
          '(fl_chart / Syncfusion) and multi-environment desktop builds. Ships '
          'with a native C++/Dart WASAPI loopback audio-capture plugin for '
          'real-time transcription.',
      tags: [
        'Flutter',
        'Windows',
        'Android',
        'SQLite',
        'REST / JWT',
        'WebSocket',
        'Provider / Cubit',
        'Hardware SDKs',
      ],
    ),
    Project(
      name: 'TPM Portal',
      subtitle: 'Trade Promotion Management',
      meta: 'RBIS Technology',
      icon: Icons.dashboard_outlined,
      summary:
          'Cross-platform trade-promotion-management portal built in React '
          'Native. Reusable, responsive component library; RESTful APIs over '
          'Axios with secure auth workflows and real-time data sync. '
          'Offline-first with SQLite + AsyncStorage for uninterrupted field use. '
          'State and navigation handled with React Hooks and the Context API.',
      tags: [
        'React Native',
        'JavaScript',
        'React Hooks',
        'Context API',
        'SQLite',
        'AsyncStorage',
        'Axios',
      ],
    ),
    Project(
      name: 'Rider Reach',
      subtitle: 'Rider & Field-Agent App',
      meta: 'v1.0.11',
      icon: Icons.two_wheeler,
      summary:
          'Rider / field-agent companion app in Flutter. Real-time dispatch and '
          'messaging over SignalR, in-app video playback (video_player / Chewie) '
          'with brightness and wakelock control, live GPS tracking (Geolocator), '
          'and an offline SQLite cache. Google & Apple Sign-In, OTP flows and '
          'multi-step onboarding.',
      tags: [
        'Flutter',
        'SignalR',
        'SQLite',
        'Geolocator',
        'Video',
        'Google / Apple Sign-In',
      ],
    ),
    Project(
      name: 'Safroo — Tourist & Guide Suite',
      subtitle: 'Two-App Tourism Platform',
      meta: 'v1.0.21 / v1.0.16',
      icon: Icons.travel_explore,
      summary:
          'A two-app tourism platform in Flutter. The Tourist app handles '
          'discovery, calendar-based bookings, Stripe payments, Google Maps & '
          'geocoding, ratings and itinerary PDFs; the Guide companion manages '
          'schedules, real-time updates over SignalR and traveller messaging. '
          'Shared stack: Firebase Cloud Messaging with local notifications, '
          'Google/Apple Sign-In, Syncfusion PDF viewer and an offline-tolerant '
          'HTTP layer.',
      tags: [
        'Flutter',
        'Stripe',
        'Google Maps',
        'SignalR',
        'Firebase',
        'PDF',
        'Provider',
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Personal projects / Labs
  // ---------------------------------------------------------------------------
  static const List<Project> personalProjects = [
    Project(
      name: 'ReceiptIQ',
      subtitle: 'Expense & Receipt Analyzer',
      icon: Icons.receipt_long_outlined,
      summary:
          'Snap a receipt and Gemini (via Firebase AI) returns structured '
          'merchant, date, category and line items against a strict JSON schema. '
          'On-device Hive storage, spending dashboards (fl_chart) and ML Kit OCR.',
      tags: ['Flutter', 'Firebase AI (Gemini)', 'Hive', 'ML Kit'],
    ),
    Project(
      name: 'Task Manager',
      subtitle: 'Offline-first',
      icon: Icons.checklist_rtl_outlined,
      summary:
          'Priority tasks with subtask checklists, categories, trash / restore '
          'and local due-date reminders. Offline-first Hive cache with a '
          'background engine that syncs to an ASP.NET Core + JWT backend.',
      tags: ['Flutter', 'BLoC', 'Hive', 'Dio', 'REST / JWT'],
    ),
    Project(
      name: 'LAN Messenger Pro',
      subtitle: 'Serverless Wi-Fi Chat',
      icon: Icons.wifi_tethering,
      summary:
          'Real-time chat over local Wi-Fi with no server. Automatic '
          'UDP-broadcast peer discovery, direct TCP transport and AES-256 '
          'encrypted messages — no accounts, no cloud, no internet.',
      tags: ['Flutter', 'Riverpod', 'UDP / TCP Sockets', 'AES-256', 'SQLite'],
    ),
    Project(
      name: 'Frank AI',
      subtitle: 'AI CRM Platform UI',
      icon: Icons.auto_awesome_outlined,
      summary:
          'A premium AI CRM / productivity platform interface — CRM, contacts, '
          'projects, billing, analytics, AI tools, team and support modules on a '
          'custom dark design system.',
      tags: ['Flutter', 'Riverpod', 'go_router', 'Design System'],
    ),
    Project(
      name: 'Lumina Grid',
      subtitle: 'Tic Tac Toe',
      icon: Icons.grid_3x3,
      summary:
          'A glassmorphic tic-tac-toe game: local pass-and-play plus a minimax '
          'AI with six difficulty levels, win-rate statistics and a personal '
          'difficulty-ladder leaderboard. Design hand-translated from Google '
          'Stitch.',
      tags: ['Flutter', 'Minimax AI', 'shared_preferences'],
    ),
    Project(
      name: 'BMI Calculator',
      subtitle: 'Material 3',
      icon: Icons.monitor_weight_outlined,
      summary:
          'A responsive Material 3 BMI tool — gender selection, interactive '
          'sliders, a circular result indicator, light / dark themes and '
          'category analysis, wired to Firebase Analytics, Crashlytics and '
          'Remote Config.',
      tags: ['Flutter', 'GetX', 'Material 3', 'Firebase'],
    ),
    Project(
      name: 'Battery Charging Speed Tracker',
      subtitle: 'System Overlay',
      icon: Icons.battery_charging_full_outlined,
      summary:
          'A live charging-rate monitor with an animated gauge and metric cards, '
          'plus a floating system overlay bubble that reports charging speed '
          'over any app.',
      tags: ['Flutter', 'battery_plus', 'Overlay Window'],
    ),
    Project(
      name: 'Dating App UI Clone',
      subtitle: 'Reference-matched',
      icon: Icons.favorite_border,
      summary:
          'A seven-screen dating-app UI matched to a reference video. Home is '
          'backed by a live randomuser.me API in full Clean Architecture + BLoC; '
          'the remaining screens are UI-only with mock data. go_router, get_it '
          'DI and Dio.',
      tags: ['Flutter', 'BLoC', 'Clean Architecture', 'go_router'],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Experience + education timeline
  // ---------------------------------------------------------------------------
  static const List<TimelineEntry> timeline = [
    TimelineEntry(
      title: 'Mobile Application Developer',
      place: 'RBIS Technology',
      period: 'Jan 2024 — Present',
      highlight: true,
      detail:
          'Build and maintain cross-platform Flutter and React Native apps plus '
          'native Android features in Kotlin / Jetpack Compose. Shipped '
          'production POS and enterprise systems on REST, Firebase, SQLite and '
          'JWT; designed offline-first architectures with Clean Architecture and '
          'the Repository pattern; implemented promotions, loyalty programs, '
          'Bluetooth hardware integration and PDF receipt generation; managed '
          'Play Store / App Store releases in an Agile team.',
    ),
    TimelineEntry(
      title: 'Master of Computer Applications (MCA)',
      place: 'North Maharashtra University',
      period: 'CGPA 9.15',
      detail:
          'Postgraduate degree in computer applications — software engineering, '
          'data structures, DBMS and mobile / web development.',
    ),
    TimelineEntry(
      title: 'Bachelor of Computer Applications (BCA)',
      place: 'Bharati Vidyapeeth (Deemed to be University)',
      period: 'CGPA 9.5',
      detail:
          'Undergraduate degree in computer applications — programming '
          'fundamentals, OOP, databases and the foundations of app development.',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Contact
  // ---------------------------------------------------------------------------
  static const String contactBlurb =
      "I'm open to new opportunities and interesting mobile problems. Whether you "
      'have a project in mind, a role to fill, or just want to talk shop — reach out.';
}
