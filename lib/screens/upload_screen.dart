import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/csv_service.dart';
import '../services/prediction_service.dart';
import '../services/storage_service.dart';
import 'analysis_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String path = result.files.single.path!;
      String fileName = result.files.single.name;

      List<double> values = await CsvService.readCSV(path);

      int safe = 0;
      int unsafe = 0;

      for (var v in values) {
        String res = PredictionService.predict([v]);
        if (res == "Safe") {
          safe++;
        } else {
          unsafe++;
        }
      }

      double safePercent = (safe / values.length) * 100;
      double unsafePercent = (unsafe / values.length) * 100;

      // ✅ SAVE DATA
      await StorageService.saveUpload({
        "fileName": fileName,
        "safe": safePercent,
        "unsafe": unsafePercent,
        "date": DateTime.now().toString(),
      });

      // NAVIGATE
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalysisScreen(
            safe: safePercent,
            unsafe: unsafePercent,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Dataset')),
      body: Center(
        child: ElevatedButton(
          onPressed: pickFile,
          child: const Text("Upload CSV File"),
        ),
      ),
    );
  }
}