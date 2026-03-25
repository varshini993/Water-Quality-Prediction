import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {

  final String result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Result"),
      ),

      body: Center(

        child: Text(

          "Water Quality: $result",

          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: result == "Safe"
                ? Colors.green
                : Colors.red,
          ),

        ),

      ),

    );
  }
}