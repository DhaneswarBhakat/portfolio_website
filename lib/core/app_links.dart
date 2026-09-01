/// Central place for outbound links. Fill in the TODO values when available.
abstract final class AppLinks {
  /// Real — used for the contact mail row and the footer.
  static const String email = 'dhaneswarbhakat2000@gmail.com';

  /// Real — used for the optional phone row (tel:).
  static const String phone = '+918863948549';

  // TODO: host the résumé PDF (DRUpdated.pdf) somewhere public (Google Drive
  // share link, personal domain, GitHub release asset, …) and paste the URL here.
  static const String resumeUrl = '';

  // TODO: add the GitHub profile URL, e.g. 'https://github.com/<username>'.
  static const String githubUrl = '';

  // TODO: add the LinkedIn profile URL, e.g. 'https://linkedin.com/in/<handle>'.
  static const String linkedinUrl = '';

  static bool get hasResume => resumeUrl.isNotEmpty;
  static bool get hasGithub => githubUrl.isNotEmpty;
  static bool get hasLinkedin => linkedinUrl.isNotEmpty;
}
