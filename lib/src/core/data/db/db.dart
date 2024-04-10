import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IDatabase {
  IDatabase();

  factory IDatabase.sharedPreferences() => DatabaseSharePreferences();

  FutureOr<void> init();
  FutureOr<void> close();
  FutureOr<bool> save<T>({required String key, required T value});
  FutureOr<bool> delete({required String key});
  FutureOr<T?> get<T>({required String key});
}

final class DatabaseSharePreferences implements IDatabase {
  DatabaseSharePreferences();

  late final SharedPreferences _prefs;

  @override
  FutureOr<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  FutureOr<void> close() {
  }

  @override
  FutureOr<bool> delete({required String key}) => _prefs.remove(key);

  @override
  FutureOr<T?> get<T>({required String key}) => _prefs.get(key) as T?;

  @override
  FutureOr<bool> save<T>({required String key, required T value}) {
    print('key: $key value: $value');
    return switch (value) {
      int() => _prefs.setInt(key, value),
      double() => _prefs.setDouble(key, value),
      bool() => _prefs.setBool(key, value),
      String() => _prefs.setString(key, value),
      List<String>() => _prefs.setStringList(key, value),
      _ => throw Exception('Type not supported'),

    };
  }
}