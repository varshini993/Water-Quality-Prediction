import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String key = "uploads";

  static Future<void> saveUpload(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> existing = prefs.getStringList(key) ?? [];

    existing.add(jsonEncode(data));

    await prefs.setStringList(key, existing);
  }

  static Future<List<Map<String, dynamic>>> getUploads() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = prefs.getStringList(key) ?? [];

    return data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  static Future<void> clearUploads() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}