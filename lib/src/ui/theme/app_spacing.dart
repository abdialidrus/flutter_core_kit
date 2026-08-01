/// App Spacing System
/// Consistent spacing, radius, elevation, and sizing tokens.
/// These are project-agnostic (an 8pt-style grid) and safe to share as-is
/// across every app that consumes core_kit.
class AppSpacing {
  AppSpacing._();

  // Base spacing scale
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  // Page / section padding
  static const double pagePadding = 16.0;
  static const double sectionSpacing = 24.0;

  // Card padding
  static const double cardPadding = 16.0;
  static const double cardPaddingLarge = 24.0;

  // Button padding
  static const double buttonPaddingHorizontal = 24.0;
  static const double buttonPaddingVertical = 12.0;

  // Input padding
  static const double inputPaddingHorizontal = 16.0;
  static const double inputPaddingVertical = 14.0;

  // Border radius
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusFull = 999.0;

  // Icon sizes
  static const double iconXS = 14.0;
  static const double iconSM = 18.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;

  // Elevation
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;

  // Divider
  static const double dividerThickness = 1.0;

  // Avatar sizes
  static const double avatarSM = 32.0;
  static const double avatarMD = 48.0;
  static const double avatarLG = 64.0;
  static const double avatarXL = 96.0;
}
