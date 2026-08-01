import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences wrapper for simple key-value storage.
///
/// Call [init] once before using any other method (typically in `main()`).
class PreferencesService {
  SharedPreferences? _prefs;

  /// Whether [init] has been called successfully.
  bool get isInitialized => _prefs != null;

  /// Initialize shared preferences. Must be called before any other method.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get _instance {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError(
        'PreferencesService has not been initialized. '
        'Call PreferencesService.init() before using it.',
      );
    }
    return prefs;
  }

  // String operations
  Future<bool> setString(String key, String value) {
    return _instance.setString(key, value);
  }

  String? getString(String key) {
    return _instance.getString(key);
  }

  // Int operations
  Future<bool> setInt(String key, int value) {
    return _instance.setInt(key, value);
  }

  int? getInt(String key) {
    return _instance.getInt(key);
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) {
    return _instance.setBool(key, value);
  }

  bool? getBool(String key) {
    return _instance.getBool(key);
  }

  // Double operations
  Future<bool> setDouble(String key, double value) {
    return _instance.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _instance.getDouble(key);
  }

  // StringList operations
  Future<bool> setStringList(String key, List<String> value) {
    return _instance.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _instance.getStringList(key);
  }

  // Remove key
  Future<bool> remove(String key) {
    return _instance.remove(key);
  }

  // Check if key exists
  bool containsKey(String key) {
    return _instance.containsKey(key);
  }

  // Clear all
  Future<bool> clear() {
    return _instance.clear();
  }
}
