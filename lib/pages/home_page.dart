import 'package:flutter/material.dart';

import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/experience_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/mobile_bottom_nav.dart';
import '../sections/nav_bar.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../core/responsive.dart';
import '../theme/app_spacing.dart';
import '../widgets/dot_grid_background.dart';
import '../widgets/reveal_on_scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'top': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'experience': GlobalKey(),
    'contact': GlobalKey(),
  };

  String? _activeId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Mark whichever tracked section currently sits just below the nav bar.
    const anchor = AppSpacing.navHeight + 8;
    String? current;
    for (final id in ['about', 'skills', 'projects', 'experience', 'contact']) {
      final ctx = _sectionKeys[id]!.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final dy = box.localToGlobal(Offset.zero).dy;
      if (dy <= anchor + 120) current = id;
    }
    if (current != _activeId) setState(() => _activeId = current);
  }

  Future<void> _navigateTo(String id) async {
    final ctx = _sectionKeys[id]?.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
    // Nudge back so the fixed nav doesn't cover the section heading.
    if (id != 'top' && _scrollController.hasClients) {
      final target =
          (_scrollController.offset - AppSpacing.navHeight - 12).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Scaffold(
      body: Stack(
        children: [
          const DotGridBackground(),
          Positioned.fill(
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    KeyedSubtree(
                      key: _sectionKeys['top'],
                      child: HeroSection(
                        onViewProjects: () => _navigateTo('projects'),
                        onContact: () => _navigateTo('contact'),
                      ),
                    ),
                    _Reveal(
                      id: 'about',
                      keyRef: _sectionKeys['about']!,
                      child: const AboutSection(),
                    ),
                    _Reveal(
                      id: 'skills',
                      keyRef: _sectionKeys['skills']!,
                      child: const SkillsSection(),
                    ),
                    _Reveal(
                      id: 'projects',
                      keyRef: _sectionKeys['projects']!,
                      child: const ProjectsSection(),
                    ),
                    _Reveal(
                      id: 'experience',
                      keyRef: _sectionKeys['experience']!,
                      child: const ExperienceSection(),
                    ),
                    _Reveal(
                      id: 'contact',
                      keyRef: _sectionKeys['contact']!,
                      child: const ContactSection(),
                    ),
                    if (!isMobile)
                      const FooterSection()
                    else
                      const SizedBox(height: 96),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(onNavigate: _navigateTo, activeId: _activeId),
          ),
          if (isMobile)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MobileBottomNav(
                onNavigate: _navigateTo,
                activeId: _activeId,
              ),
            ),
        ],
      ),
    );
  }
}

class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.id,
    required this.keyRef,
    required this.child,
  });

  final String id;
  final GlobalKey keyRef;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: keyRef,
      child: RevealOnScroll(id: id, child: child),
    );
  }
}
