import 'package:flutter/material.dart';
import 'analysis_screen.dart';

class PhTestScreen extends StatefulWidget {
  const PhTestScreen({super.key});

  @override
  State<PhTestScreen> createState() => _PhTestScreenState();
}

class _PhTestScreenState extends State<PhTestScreen> {
  final phController = TextEditingController();

  void analyze() {
    double ph = double.tryParse(phController.text) ?? 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisScreen(ph: ph),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("pH Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter pH Value",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: analyze,
              child: const Text("Analyze"),
            ),
          ],
        ),
      ),
    );
  }
}