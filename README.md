# Portfolio Website

Personal portfolio site for **Dhaneswar Bhakat — Mobile Application Developer**, built
with Flutter (web-first, but the app builds on every Flutter platform).

The UI follows the "Kinetic Logic" design system from the Google Stitch project
*Dhaneswar Bhakat Mobile Portfolio*: dark "deep space" palette, electric-blue accent,
glassmorphism cards, dot-grid texture, Inter + JetBrains Mono.

## Run

```bash
flutter pub get
flutter run -d chrome        # or: flutter build web
```

## Structure

| Path | Purpose |
|---|---|
| `lib/theme/` | Colours, type scale, spacing, `ThemeData` |
| `lib/core/` | `app_links.dart` (contact links), `launcher.dart` (url_launcher wrapper), `responsive.dart` |
| `lib/data/portfolio_data.dart` | **All site copy** — edit here to change content |
| `lib/models/models.dart` | `Project`, `SkillGroup`, `TimelineEntry`, `Stat` |
| `lib/widgets/` | Shared UI: `GlassCard`, `TechChip`, `ProjectCard`, `RevealOnScroll`, buttons, dot grid |
| `lib/sections/` | One file per page section (nav, hero, about, skills, projects, experience, contact, footer) |
| `lib/pages/home_page.dart` | Single scrolling page: section keys, nav scroll, active-section tracking |

## TODO — fill these in

Set the placeholders in [`lib/core/app_links.dart`](lib/core/app_links.dart):

- `resumeUrl` — public URL for the résumé PDF (`DRUpdated.pdf`). Until set, the
  "Download Résumé" button shows a "coming soon" snackbar.
- `githubUrl` — GitHub profile URL.
- `linkedinUrl` — LinkedIn profile URL.

The hero avatar is a styled "DB" placeholder (no photo). Drop a real headshot into
`assets/images/` and swap it into `lib/sections/hero_section.dart` (`_HeroAvatar`) when ready.
