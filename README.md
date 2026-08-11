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

## Component Usage Guide

### Typography & Text
`core_kit` does not provide custom Text widgets. Instead, it relies on standard Flutter `Text` widgets combined with the injected `ThemeData.textTheme` defined by your `AppTypography` implementation. You can use the `BuildContextThemeX` extension to make accessing theme data much shorter.

```dart
// Using standard typography scales
Text(
  'Display Large',
  style: context.textTheme.displayLarge,
)

Text(
  'Body Medium',
  style: context.textTheme.bodyMedium,
)

// The color is automatically bound to `textPrimary`, `textSecondary`, or `textTertiary` 
// based on the style definition in `buildAppTheme`. To override:
Text(
  'Success Text',
  style: context.textTheme.bodyMedium?.copyWith(
    color: context.semanticColors?.success,
  ),
)
```

### 1. Buttons (`widgets/buttons/`)
Maintain consistent call-to-action styling across the app.
```dart
PrimaryButton(
  text: 'Submit',
  onPressed: () => print('Submitted'),
)

SecondaryButton(
  text: 'Cancel',
  onPressed: () => Navigator.pop(context),
)

DangerButton(
  text: 'Delete',
  onPressed: () => deleteItem(),
)

AppIconButton(
  icon: Icons.add,
  onPressed: () => addItem(),
)
```

### 2. Inputs (`widgets/inputs/`)
Pre-styled input fields with consistent error states, borders, and typography.
```dart
AppTextField(
  label: 'Email',
  hintText: 'Enter your email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
)

AppPasswordField(
  label: 'Password',
  controller: passwordController,
)

AppDropdown<String>(
  label: 'Select Role',
  value: selectedRole,
  items: const [
    DropdownMenuItem(value: 'admin', child: Text('Admin')),
    DropdownMenuItem(value: 'user', child: Text('User')),
  ],
  onChanged: (val) => setState(() => selectedRole = val),
)

AppSwitchTile(
  title: 'Enable Notifications',
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
)
```

### 3. Feedback (`widgets/feedback/`)
Standardized components for loading, empty states, and errors.
```dart
// Full screen loading
if (isLoading) return const AppLoadingView();

// Empty state
if (items.isEmpty) {
  return EmptyStateWidget(
    title: 'No Data Found',
    message: 'Try adjusting your filters.',
    onActionPressed: () => fetchItems(),
    actionText: 'Retry',
  );
}

// Error state
if (hasError) {
  return ErrorStateWidget(
    title: 'Something went wrong',
    onRetry: () => fetchItems(),
  );
}

// Skeleton loading for lists
return ListView.builder(
  itemCount: 5,
  itemBuilder: (context, index) => const AppShimmerListTile(),
);
```

### 4. Layout & Data Display (`widgets/layout/` & `widgets/data_display/`)
Containers and list items with theme-aware borders and padding.
```dart
AppCard(
  padding: const EdgeInsets.all(AppSpacing.md),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionHeader(title: 'Recent Activity'),
      const AppDivider(),
      AppListTile(
        title: 'New Order Received',
        subtitle: 'Order #12345',
        leading: AppAvatar(imageUrl: 'https://...', fallbackText: 'JD'),
        trailing: AppBadge(
          label: 'New', 
          color: context.semanticColors?.info,
        ),
      ),
    ],
  ),
)
```

### 5. Services (`services/`)
Helper classes for common UI tasks like snackbars and dialogs, plus application utilities.
```dart
// Show snackbar
SnackbarHelper.showSuccess(context, 'Profile updated successfully!');
SnackbarHelper.showError(context, 'Failed to update profile.');

// Show dialog
DialogHelper.showConfirmation(
  context,
  title: 'Logout',
  message: 'Are you sure you want to log out?',
  onConfirm: () => logout(),
);

// Logging
LoggerService.i('User logged in successfully');
LoggerService.e('Network request failed', error: e, stackTrace: stackTrace);

// Preferences
await sl<PreferencesService>().setString('token', myToken);
```

### 6. Data & Error Handling (`data/` & `error/`)
Standardized way to handle domain logic and functional error handling using the `Result<T>` pattern.
```dart
// 1. Return a Result from a repository or use case
Future<Result<User>> getUser() async {
  try {
    final user = await api.fetchUser();
    return Ok(user);
  } on DioException catch (e) {
    return Error(NetworkFailure(e.message ?? 'Network Error'));
  } catch (e) {
    return Error(ServerFailure(e.toString()));
  }
}

// 2. Handling Result in UI or Bloc/ViewModel
final result = await getUser();
result.when(
  ok: (user) => print('Got user: ${user.name}'),
  error: (failure) => SnackbarHelper.showError(context, failure.message),
);
```

### 7. Dependency Injection (`di/`)
Global service locator.
```dart
// Register dependencies (usually in injection.dart)
sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

// Access dependencies
final authRepo = sl<AuthRepository>();
```

### 8. Network (`network/`)
Pre-configured Dio client with interceptors for authentication and logging.
```dart
// Access the pre-configured Dio instance
final dio = sl<DioClient>().dio;

// Make a request that requires authentication (default behavior if AuthInterceptor is added)
final response = await dio.get('/profile');

// Make a public request bypassing the AuthInterceptor
final publicResponse = await dio.get(
  '/public-config',
  options: Options(
    extra: RequestExtras(requiresAuth: false).toMap(),
  ),
);
```
