import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatelessWidget {

  final oldController = TextEditingController();
  final newController = TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: oldController,
              decoration: const InputDecoration(labelText: "Old Password"),
            ),

            TextField(
              controller: newController,
              decoration: const InputDecoration(labelText: "New Password"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Update Password"),
              onPressed: () async {

                final prefs = await SharedPreferences.getInstance();
                String? old = prefs.getString("password");

                if (old == oldController.text) {
                  await prefs.setString("password", newController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password Updated")),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Wrong Old Password")),
                  );
                }
              },
            )

          ],
        ),
      ),
    );
  }
}