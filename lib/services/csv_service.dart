import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';

class CsvService {

  static Future<List<double>> readCSV(String path) async {

    final input = File(path).openRead();

    final rows = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    List<double> values = [];

    // Skip header (start from 1)
    for (int i = 1; i < rows.length; i++) {
      for (var item in rows[i]) {

        try {
          values.add(double.parse(item.toString()));
        } catch (e) {
          // ignore non-numeric values
        }

      }
    }

    return values;
  }
}