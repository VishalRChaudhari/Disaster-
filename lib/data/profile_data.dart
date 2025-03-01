import 'package:shared_preferences/shared_preferences.dart';

class ProfileData {
  static const String _nameKey = "user_name";
  static const String _emailKey = "user_email";

  static Future<void> saveProfile(String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
  }

  static Future<Map<String, String?>> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString(_nameKey);
    String? email = prefs.getString(_emailKey);

    return {
      'name': name,
      'email': email,
    };
  }

  static Future<void> clearProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
  }
}
