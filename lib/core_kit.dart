/// core_kit
///
/// Shared, theme-driven core services and widgets for reuse across Flutter
/// projects. Nothing in this package hardcodes brand colors or fonts —
/// each consuming app supplies its own [AppColorScheme] and [AppTypography]
/// implementation and calls [buildAppTheme] to assemble its ThemeData.
///
/// Usage:
/// ```dart
/// import 'package:core_kit/core_kit.dart';
/// ```
library;

export 'src/ui/theme/theme.dart';
export 'src/ui/widgets/widgets.dart';
export 'src/services/services.dart';
export 'src/utils/utils.dart';
export 'src/data/data.dart';
export 'src/di/di.dart';
export 'src/error/error.dart';
export 'src/network/network.dart';
