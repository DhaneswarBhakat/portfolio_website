import 'package:flutter/widgets.dart';

@immutable
class Project {
  const Project({
    required this.name,
    required this.summary,
    required this.tags,
    required this.icon,
    this.subtitle,
    this.meta,
  });

  final String name;
  final String? subtitle;
  final String summary;
  final List<String> tags;
  final IconData icon;

  /// Short trailing note, e.g. "v2.1.6" or "RBIS Technology".
  final String? meta;
}

@immutable
class SkillGroup {
  const SkillGroup({required this.title, required this.icon, required this.skills});

  final String title;
  final IconData icon;
  final List<String> skills;
}

@immutable
class TimelineEntry {
  const TimelineEntry({
    required this.title,
    required this.place,
    required this.period,
    required this.detail,
    this.highlight = false,
  });

  final String title;
  final String place;
  final String period;
  final String detail;

  /// Renders as the "current" node (filled dot, primary text).
  final bool highlight;
}

@immutable
class Stat {
  const Stat(this.value, this.label);
  final String value;
  final String label;
}
