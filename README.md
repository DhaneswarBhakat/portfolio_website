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

## Deploy (GitHub Pages)

[`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) builds the web app and
publishes it on every push to `main`. One-time setup:

1. **GitHub → repo Settings → Pages → Build and deployment → Source: “GitHub Actions”.**
2. Push to `main`. The **Deploy to GitHub Pages** action builds and publishes.
3. Site goes live at `https://dhaneswarbhakat.github.io/portfolio_website/`.

The build passes `--base-href "/portfolio_website/"` because it is served from a
repo sub-path. For a user site (`dhaneswarbhakat.github.io` repo) or a custom
domain, change that to `"/"` in the workflow (and add a `CNAME` for a domain).

Build locally the same way:

```bash
flutter build web --release --base-href "/portfolio_website/"
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

## Links

Email, phone, résumé (Google Drive), GitHub and LinkedIn are all set in
[`lib/core/app_links.dart`](lib/core/app_links.dart).

## Still to do

The hero avatar is a styled "DB" placeholder (no photo). Drop a real headshot into
`assets/images/` and swap it into `lib/sections/hero_section.dart` (`_HeroAvatar`) when ready.
