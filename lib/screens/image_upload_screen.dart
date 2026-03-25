import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_analysis_screen.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? image;

  Future pickImage() async {
    final picked =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  void analyze() {
    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageAnalysisScreen(image: image!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Water Image")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image != null
              ? Image.file(image!, height: 200)
              : const Text("No image selected"),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: pickImage,
            child: const Text("Pick Image"),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: analyze,
            child: const Text("Analyze"),
          ),
        ],
      ),
    );
  }
}