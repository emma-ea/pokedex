import 'package:hive/hive.dart';

class Preferences {
  static const _preferencesBox = '_preferencesBox';
  static const _favKey = '_favKey';
  final Box<Map<dynamic, dynamic>> _box;

  Preferences._(this._box);

  static Future<Preferences> getInstance([String boxName = _preferencesBox]) async {
    final box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
    return Preferences._(box);
  }

  Map<dynamic, dynamic>? getFav() => _getValue(_favKey);

  Future<void> setFav(Map<dynamic, dynamic> val) => _setValue(_favKey, val);

  Map<dynamic, dynamic>? _getValue(String key) => _box.get(key, defaultValue: {});

  Future<void> _setValue(String key, Map<dynamic, dynamic> value) => _box.put(key, value);
}
