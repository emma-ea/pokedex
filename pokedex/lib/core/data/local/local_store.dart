import 'package:hive/hive.dart';

class Preferences {
  static const _preferencesBox = '_preferencesBox';
  static const _favKey = '_favKey';
  final Box<Map<int, String>> _box;

  Preferences._(this._box);

  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<Map<int, String>>(_preferencesBox);
    return Preferences._(box);
  }

  Map<int, String>? getFav() => _getValue(_favKey);

  Future<void> setFav(Map<int, String> val) => _setValue(_favKey, val);

  Map<int, String>? _getValue(String key) => _box.get(key, defaultValue: {});

  Future<void> _setValue(String key, Map<int, String> value) => _box.put(key, value);
}
