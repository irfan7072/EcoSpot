import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _reportKey = "saved_reports";


  static Future<void> saveReport(String imagePath, String location, String description) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existingReports = prefs.getStringList(_reportKey) ?? [];


    Map<String, String> report = {
      "image": imagePath,
      "location": location,
      "description": description,
    };
    existingReports.add(jsonEncode(report));

    await prefs.setStringList(_reportKey, existingReports);
  }


  static Future<List<Map<String, String>>> getReports() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> storedReports = prefs.getStringList(_reportKey) ?? [];

    return storedReports.map((report) => Map<String, String>.from(jsonDecode(report))).toList();
  }

 
  static Future<void> deleteReport(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> reports = prefs.getStringList(_reportKey) ?? [];

    if (index >= 0 && index < reports.length) {
      reports.removeAt(index);
      await prefs.setStringList(_reportKey, reports);
    }
  }
}
