import 'package:flutter/material.dart';

/// Contract for an app's color palette.
///
/// core_kit ships no concrete colors — each app implements this interface
/// (typically as two classes, one per [Brightness]) with its own brand
/// values, then passes an instance into [buildAppTheme].
///
/// Keep this interface to *universal* theme concepts. Domain-specific
/// semantics (e.g. delivery status colors) belong in the consuming app,
/// not here.
abstract class AppColorScheme {
  // Brand
  Color get primary;
  Color get primaryLight;
  Color get primaryDark;
  Color get secondary;
  Color get secondaryLight;
  Color get secondaryDark;

  // Surfaces
  Color get background;
  Color get onBackground;
  Color get surface;
  Color get onSurface;
  Color get surfaceVariant;
  Color get onSurfaceVariant;

  // Text
  Color get textPrimary;
  Color get textSecondary;
  Color get textTertiary;
  Color get textDisabled;

  // Semantic — success
  Color get success;
  Color get successLight;
  Color get successDark;
  Color get onSuccess;

  // Semantic — error
  Color get error;
  Color get errorLight;
  Color get errorDark;
  Color get onError;

  // Semantic — warning
  Color get warning;
  Color get warningLight;
  Color get warningDark;
  Color get onWarning;

  // Semantic — info
  Color get info;
  Color get infoLight;
  Color get infoDark;
  Color get onInfo;

  // Border / overlay
  Color get border;
  Color get divider;
  Color get overlay;
  Color get shadow;
}
