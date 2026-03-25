import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisScreen extends StatelessWidget {
  final double? ph;
  final double? safe;
  final double? unsafe;

  const AnalysisScreen({
    super.key,
    this.ph,
    this.safe,
    this.unsafe,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 CASE 1: pH Analysis → PIE CHART
    if (ph != null) {
      double safePercent;
      double unsafePercent;

      if (ph! >= 6.5 && ph! <= 8.5) {
        // closer to 7 = more safe
        double diff = (ph! - 7).abs();
        safePercent = 100 - (diff * 20); // dynamic
        safePercent = safePercent.clamp(60, 100);
      } else {
        double diff = (ph! - 7).abs();
        safePercent = 50 - (diff * 10);
        safePercent = safePercent.clamp(0, 40);
      }

      unsafePercent = 100 - safePercent;

      bool isSafe = safePercent > unsafePercent;

      return Scaffold(
        appBar: AppBar(title: const Text("pH Analysis")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "pH Value: $ph",
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: safePercent,
                        title: "${safePercent.toStringAsFixed(1)}%",
                        color: Colors.green,
                        radius: 80,
                      ),
                      PieChartSectionData(
                        value: unsafePercent,
                        title: "${unsafePercent.toStringAsFixed(1)}%",
                        color: Colors.red,
                        radius: 80,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                isSafe
                    ? "✅ Water is SAFE to drink"
                    : "❌ Water is NOT SAFE to drink",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSafe ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 🔹 CASE 2: Upload Data Analysis (UNCHANGED)
    if (safe != null && unsafe != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Data Analysis")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              safe! > unsafe!
                  ? "SAFE WATER"
                  : "UNSAFE WATER",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: safe! > unsafe!
                    ? Colors.green
                    : Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: safe!,
                      title: "${safe!.toStringAsFixed(1)}%",
                      color: Colors.green,
                    ),
                    PieChartSectionData(
                      value: unsafe!,
                      title: "${unsafe!.toStringAsFixed(1)}%",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text("Safe: ${safe!.toStringAsFixed(1)}%"),
            Text("Unsafe: ${unsafe!.toStringAsFixed(1)}%"),
          ],
        ),
      );
    }

    return const Scaffold(
      body: Center(child: Text("No Data Available")),
    );
  }
}