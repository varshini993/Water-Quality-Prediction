import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  // ✅ Signup
  static Future<void> signup(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("password", password);

    // Save login date
    await prefs.setString(
      "loginDate",
      DateTime.now().toString(),
    );
  }

  // ✅ Login
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String savedEmail = prefs.getString("email") ?? "";
    String savedPassword = prefs.getString("password") ?? "";

    if (email == savedEmail && password == savedPassword) {
      // Update login date
      await prefs.setString(
        "loginDate",
        DateTime.now().toString(),
      );
      return true;
    }

    return false;
  }

  // ✅ Check Auto Login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? "";
    return email.isNotEmpty;
  }

  // ✅ Get User Data
  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString("name") ?? "",
      "email": prefs.getString("email") ?? "",
      "password": prefs.getString("password") ?? "",
      "loginDate": prefs.getString("loginDate") ?? "",
      "image": prefs.getString("image") ?? "",
    };
  }

  // ✅ Save Profile Image
  static Future<void> saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("image", path);
  }

  // ✅ Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}