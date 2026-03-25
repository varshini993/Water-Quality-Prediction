import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryService {
  static Future<void> saveHistory(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> history = prefs.getStringList("history") ?? [];

    history.add(jsonEncode(data));

    await prefs.setStringList("history", history);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> history = prefs.getStringList("history") ?? [];

    return history.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }
}