# core_kit

Shared, theme-driven core services and widgets for reuse across Flutter projects.

Nothing in this package hardcodes brand colors or fonts. Each consuming app
supplies its own `AppColorScheme` and `AppTypography` implementation and
calls `buildAppTheme()` to assemble its `ThemeData`.

## Install

```yaml
dependencies:
  core_kit:
    git:
      url: https://github.com/abdialidrus/flutter_core_kit
      ref: v1.0.0
```

## Set up your app's theme

1. Implement `AppColorScheme` for each brightness your app supports:

```dart
// lib/theme/my_color_scheme.dart
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';

class MyLightColors implements AppColorScheme {
  const MyLightColors();

  // Brand
  @override Color get primary => const Color(0xFF1C4688);
  @override Color get primaryLight => const Color(0xFF2D68C4);
  @override Color get primaryDark => const Color(0xFF0D2751);
  @override Color get secondary => const Color(0xFF031028);
  @override Color get secondaryLight => const Color(0xFF0D2751);
  @override Color get secondaryDark => const Color(0xFF020B1A);

  // Surfaces
  @override Color get background => const Color(0xFFE8EDF3);
  @override Color get onBackground => const Color(0xFF27282B);
  @override Color get surface => const Color(0xFFFFFFFF);
  @override Color get onSurface => const Color(0xFF27282B);
  @override Color get surfaceVariant => const Color(0xFFF5F5F5);
  @override Color get onSurfaceVariant => const Color(0xFF27282B);

  // Text
  @override Color get textPrimary => const Color(0xFF27282B);
  @override Color get textSecondary => const Color(0xFF46484C);
  @override Color get textTertiary => const Color(0xFF686A70);
  @override Color get textDisabled => const Color(0xFFCCCCCC);

  // Semantic — success
  @override Color get success => const Color(0xFF4CAF50);
  @override Color get successLight => const Color(0xFF81C784);
  @override Color get successDark => const Color(0xFF388E3C);
  @override Color get onSuccess => Colors.white;

  // Semantic — error
  @override Color get error => const Color(0xFFD32F2F);
  @override Color get errorLight => const Color(0xFFE57373);
  @override Color get errorDark => const Color(0xFFC62828);
  @override Color get onError => Colors.white;

  // Semantic — warning
  @override Color get warning => const Color(0xFFFF9800);
  @override Color get warningLight => const Color(0xFFFFB74D);
  @override Color get warningDark => const Color(0xFFF57C00);
  @override Color get onWarning => Colors.white;

  // Semantic — info
  @override Color get info => const Color(0xFF2D68C4);
  @override Color get infoLight => const Color(0xFF5A8ED4);
  @override Color get infoDark => const Color(0xFF1C4688);
  @override Color get onInfo => Colors.white;

  // Border / overlay
  @override Color get border => const Color.fromARGB(255, 232, 232, 232);
  @override Color get divider => const Color(0xFFEEEEEE);
  @override Color get overlay => const Color(0xCC101112);
  @override Color get shadow => const Color(0x1A101112);
}
```

2. (Optional) Override the font by extending `DefaultTypography`:

```dart
// lib/theme/my_typography.dart
import 'package:core_kit/core_kit.dart';

class MyTypography extends DefaultTypography {
  const MyTypography();

  @override
  String get fontFamily => 'Inter';
}
```

3. Build your themes and wire them into `MaterialApp`:

```dart
// lib/app.dart
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'theme/my_color_scheme.dart';
import 'theme/my_typography.dart';

final lightTheme = buildAppTheme(
  brightness: Brightness.light,
  colors: const MyLightColors(),
  typography: const MyTypography(),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: const HomeScreen(),
    );
  }
}
```

Make sure to register your font family in `pubspec.yaml` (or add the
`google_fonts` package) in the **consuming app**, not in core_kit.

## What's included

- **theme/** — `AppColorScheme` (interface), `AppTypography` +
  `DefaultTypography`, `AppSemanticColors` (success/warning/info as a
  `ThemeExtension`), `AppSpacing`, `buildAppTheme()`.
- **widgets/buttons/** — `PrimaryButton`, `SecondaryButton`, `DangerButton`,
  `AppTextButton`, `AppIconButton`, `AppFAB`.
- **widgets/inputs/** — `AppTextField`, `AppPasswordField`,
  `AppSearchField`, `AppDropdown<T>`, `AppCheckboxTile`, `AppRadioTile<T>`,
  `AppSwitchTile`, `AppDateTimePicker`.
- **widgets/feedback/** — `AppLoadingIndicator`, `AppLoadingView`,
  `EmptyStateWidget`, `ErrorStateWidget`, `AppShimmerLoader`,
  `AppShimmerListTile`, `ConnectivityBanner`.
- **widgets/layout/** — `AppCard`, `SectionHeader`, `AppDivider`,
  `AppVerticalDivider`.
- **widgets/data_display/** — `AppListTile`, `AppBadge`, `AppAvatar`.
- **widgets/navigation/** — `AppBottomSheet`.
- **services/** — `DialogHelper`, `SnackbarHelper`, `LoggerService`,
  `PreferencesService`.
- **data/** — `Result<T>` (with `Ok`, `Error`, and convenience extensions),
  `Command`, `UseCase`, `StreamUseCase`.
- **di/** — `ServiceLocator` (and `sl` global accessor).
- **error/** — `ErrorHandler`, `Failure` hierarchy (`ServerFailure`,
  `NetworkFailure`, `ClientFailure`, etc.).
- **network/** — `DioClient`, `AuthInterceptor`, `ApiLogInterceptor`,
  `RequestExtras`.

## What's intentionally _not_ here

Domain-specific widgets and colors (e.g. TMS delivery-status badges, fleet
device icons) stay in each consuming app. The rule of thumb: if a widget
needs mining/fleet or video-app domain knowledge to make sense, it doesn't
belong in `core_kit` — build it as a thin wrapper on top of the primitives
here instead (e.g. a `DeliveryStatusBadge` that wraps `AppBadge`).
