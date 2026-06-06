import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/enum/preferences.dart';
import '../../../data/datasources/local/shared_data.dart';

class SharedDataImpl implements SharedData {
  static SharedDataImpl? _instance;

  static Future<SharedDataImpl> initialize() async =>
      _instance ??= SharedDataImpl._(await _initialize());

  SharedDataImpl._(this._prefs);

  static Future<SharedPreferences> _initialize() async =>
      await SharedPreferences.getInstance();

  final SharedPreferences _prefs;

  final List<Type> _allowTypes = [String, List<String>, int, double, bool];

  @override
  T? getValue<T>(Preferences preference) {
    assert(
      _allowTypes.contains(T),
      'Type fornecido não permitido: $T, '
      'você deve providenciar um dos seguintes Types: $_allowTypes',
    );

    try {
      if (T == List<String>) {
        return _prefs.getStringList(preference.key) as T?;
      }
      return _prefs.get(preference.key) as T;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearValues() async => await _prefs.clear();

  @override
  Future<void> setValue<T>(Preferences preference, T value) async {
    assert(
      _allowTypes.contains(value.runtimeType),
      'Type fornecido não permitido: ${value.runtimeType}, '
      'você deve providenciar um dos seguintes Types: $_allowTypes',
    );

    if (value is String) {
      await _prefs.setString(preference.key, value);
    }
    if (value is List<String>) {
      await _prefs.setStringList(preference.key, value);
    }
    if (value is bool) {
      await _prefs.setBool(preference.key, value);
    }
    if (value is int) {
      await _prefs.setInt(preference.key, value);
    }
    if (value is double) {
      await _prefs.setDouble(preference.key, value);
    }
  }

  @override
  Future<void> cleanValue(Preferences preference) async =>
      await _prefs.remove(preference.key);
}
