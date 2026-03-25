import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'analysis_screen.dart';

class RecentUploadsScreen extends StatefulWidget {
  const RecentUploadsScreen({super.key});

  @override
  State<RecentUploadsScreen> createState() => _RecentUploadsScreenState();
}

class _RecentUploadsScreenState extends State<RecentUploadsScreen> {

  List<Map<String, dynamic>> uploads = [];

  @override
  void initState() {
    super.initState();
    loadUploads();
  }

  void loadUploads() async {
    uploads = await StorageService.getUploads();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent Uploads"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await StorageService.clearUploads();
              loadUploads();
            },
          )
        ],
      ),
      body: uploads.isEmpty
          ? const Center(child: Text("No uploads yet"))
          : ListView.builder(
        itemCount: uploads.length,
        itemBuilder: (context, index) {
          final item = uploads[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(item["fileName"]),
              subtitle: Text("Date: ${item["date"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnalysisScreen(
                      safe: item["safe"],
                      unsafe: item["unsafe"],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}