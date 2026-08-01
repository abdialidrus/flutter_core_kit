# Changelog

## 0.1.0

Initial release.

### Theme System
- `AppColorScheme` — abstract interface for brand color palettes
- `AppTypography` / `DefaultTypography` — type scale abstraction with Material 3 defaults
- `AppSemanticColors` — success/warning/info as a `ThemeExtension`
- `AppSpacing` — consistent spacing, radius, elevation, and sizing tokens
- `buildAppTheme()` — assembles a complete `ThemeData` from color + typography

### Widgets
- **Buttons**: `PrimaryButton`, `SecondaryButton`, `DangerButton`, `AppTextButton`, `AppIconButton`, `AppFAB`
- **Inputs**: `AppTextField`, `AppPasswordField`, `AppSearchField`, `AppDropdown<T>`, `AppCheckboxTile`, `AppRadioTile<T>`, `AppSwitchTile`, `AppDateTimePicker`
- **Feedback**: `AppLoadingIndicator`, `AppLoadingView`, `EmptyStateWidget`, `ErrorStateWidget`, `AppShimmerLoader`, `AppShimmerListTile`, `ConnectivityBanner`
- **Layout**: `AppCard`, `SectionHeader`, `AppDivider`, `AppVerticalDivider`
- **Data Display**: `AppListTile`, `AppBadge`, `AppAvatar`
- **Navigation**: `AppBottomSheet`

### Services
- `DialogHelper` — standardized confirmation, info, error, warning, and loading dialogs
- `SnackbarHelper` — themed success/error/info/warning snackbars
- `LoggerService` — centralized logging with HTTP request/response formatters
- `PreferencesService` — SharedPreferences wrapper

### Architecture
- `Result<T>` — sealed class for success/error outcomes with convenience extensions
- `Command0<T>` / `Command1<T, A>` — ViewModel interaction pattern with running/error states
- `UseCase<R, P>` / `StreamUseCase<R, P>` — clean-architecture use case abstractions
- `ServiceLocator` / `sl` — lightweight dependency injection

### Networking
- `DioClient` — HTTP client with configurable timeouts and interceptor support
- `AuthInterceptor` — token-based auth interceptor with lazy token provider
- `ApiLogInterceptor` — structured HTTP logging with body truncation
- `RequestExtras` — request metadata keys

### Error Handling
- `Failure` hierarchy — `ServerFailure`, `NetworkFailure`, `ClientFailure`, `CacheFailure`, `UnexpectedFailure`, and more
- `ErrorHandler` — converts `DioException` to typed `Failure` subclasses
