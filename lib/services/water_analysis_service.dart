import 'dart:io';
import 'package:csv/csv.dart';

class WaterAnalysisService {
  static Future<Map<String, dynamic>> analyzeCSV(File file) async {
    final input = file.readAsStringSync();
    List<List<dynamic>> rows = const CsvToListConverter().convert(input);

    if (rows.isEmpty) {
      return {"safe": 0.0, "unsafe": 100.0};
    }

    int safeCount = 0;
    int unsafeCount = 0;

    // Skip header
    for (int i = 1; i < rows.length; i++) {
      var row = rows[i];

      try {
        double ph = row[0] * 1.0;
        double hardness = row[1] * 1.0;
        double solids = row[2] * 1.0;
        double chloramines = row[3] * 1.0;
        double sulfate = row[4] * 1.0;
        double conductivity = row[5] * 1.0;
        double organic = row[6] * 1.0;
        double trihalo = row[7] * 1.0;
        double turbidity = row[8] * 1.0;

        bool isSafe = checkSafe(
          ph,
          hardness,
          solids,
          chloramines,
          sulfate,
          conductivity,
          organic,
          trihalo,
          turbidity,
        );

        if (isSafe) {
          safeCount++;
        } else {
          unsafeCount++;
        }
      } catch (e) {
        unsafeCount++;
      }
    }

    int total = safeCount + unsafeCount;

    return {
      "safe": (safeCount / total) * 100,
      "unsafe": (unsafeCount / total) * 100,
    };
  }

  static bool checkSafe(
      double ph,
      double hardness,
      double solids,
      double chloramines,
      double sulfate,
      double conductivity,
      double organic,
      double trihalo,
      double turbidity,
      ) {
    return (ph >= 6.5 && ph <= 8.5) &&
        (hardness < 200) &&
        (solids < 500) &&
        (chloramines < 4) &&
        (sulfate < 250) &&
        (conductivity < 500) &&
        (organic < 10) &&
        (trihalo < 80) &&
        (turbidity < 5);
  }
}