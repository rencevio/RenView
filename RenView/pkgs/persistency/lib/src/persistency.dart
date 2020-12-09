import 'package:shared_preferences/shared_preferences.dart';

class Persistency {
  static const _stateKey = 'state';

  Future<void> save(String json) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_stateKey, json);
  }

  Future<String> load() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_stateKey);
  }
}
