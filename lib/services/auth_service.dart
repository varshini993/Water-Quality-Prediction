import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static Future<void> signup(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("password", password);
    await prefs.setString("loginDate", DateTime.now().toString());
  }

  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("email") == email &&
        prefs.getString("password") == password;
  }

  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString("name") ?? "",
      "email": prefs.getString("email") ?? "",
      "loginDate": prefs.getString("loginDate") ?? "",
      "image": prefs.getString("image") ?? "",
    };
  }

  static Future<void> updateProfile(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", name);
    await prefs.setString("email", email);
  }

  static Future<void> saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("image", path);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}