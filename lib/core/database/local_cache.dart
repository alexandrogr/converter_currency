import 'package:injectable/injectable.dart';

@Singleton()
class LocalCache {
  final Map<String, dynamic> _cache = {};
  T fromCache<T>(String key) => _cache[key] as T;
  T addToCache<T>(String key, T value) => _cache[key] = value;
}
