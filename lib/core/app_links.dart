/// Central place for outbound links. Fill in the TODO values when available.
abstract final class AppLinks {
  /// Real — used for the contact mail row and the footer.
  static const String email = 'dhaneswarbhakat2000@gmail.com';

  /// Real — used for the optional phone row (tel:).
  static const String phone = '+918863948549';

  /// Résumé PDF (Google Drive). `export=download` streams the file straight
  /// down; swap in the `/view?usp=sharing` link instead to open the Drive preview.
  static const String resumeUrl =
      'https://drive.google.com/uc?export=download&id=1e0KD8XD8rZQZBXJEbInBOH9dpPICrQs8';

  static const String githubUrl = 'https://github.com/DhaneswarBhakat';

  static const String linkedinUrl =
      'https://www.linkedin.com/in/dhaneswarbhakat/';

  static bool get hasResume => resumeUrl.isNotEmpty;
  static bool get hasGithub => githubUrl.isNotEmpty;
  static bool get hasLinkedin => linkedinUrl.isNotEmpty;

  /// Scheme-stripped, de-trailing-slashed form for display in the UI.
  static String pretty(String url) =>
      url.replaceFirst(RegExp(r'^https?://(www\.)?'), '').replaceFirst(RegExp(r'/$'), '');
}
