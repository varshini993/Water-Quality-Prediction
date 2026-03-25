import 'dart:io';
import 'package:flutter/material.dart';

class ImageAnalysisScreen extends StatelessWidget {
  final File image;

  const ImageAnalysisScreen({super.key, required this.image});

  Map<String, dynamic> analyzeImage() {
    // simple random logic
    int hash = image.path.hashCode;

    if (hash % 2 == 0) {
      return {
        "result": "Safe",
        "safe": 80.0,
        "unsafe": 20.0,
      };
    } else {
      return {
        "result": "Unsafe",
        "safe": 30.0,
        "unsafe": 70.0,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = analyzeImage();

    return Scaffold(
      appBar: AppBar(title: const Text("Image Analysis")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.file(image, height: 200),

            const SizedBox(height: 20),

            Text(
              "Result: ${result["result"]}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: result["result"] == "Safe"
                    ? Colors.green
                    : Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            Text("Safe: ${result["safe"]}%"),
            Text("Unsafe: ${result["unsafe"]}%"),
          ],
        ),
      ),
    );
  }
}