import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text(
                "Water Quality Assessment App",
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              Text(
                "This application is developed to analyze and evaluate water quality using different approaches such as dataset analysis, pH testing, and image-based detection. "
                    "Users can upload CSV datasets containing water parameters, and the app will predict whether the water is safe or unsafe based on defined conditions. "
                    "Additionally, the pH testing feature allows users to manually input values and instantly receive analysis results. "
                    "The image analysis feature simulates detection of water quality through uploaded images.\n\n"

                    "The app also maintains a history of uploaded datasets, allowing users to revisit previous results anytime. "
                    "This project is designed for educational and demonstration purposes to showcase how mobile applications can integrate data processing and basic AI logic.\n\n"

                    "Version: 1.0.0\n"
                    "Developed using Flutter.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}