import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'about_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: ListView(

        children: [

          // 🔵 EDIT PROFILE
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Edit Profile"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()));
            },
          ),

          // 🔵 CHANGE PASSWORD
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ChangePasswordScreen()));
            },
          ),

          // 🔵 DARK MODE
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDarkMode.value,
            onChanged: (val) {
              isDarkMode.value = val;
            },
          ),

          // 🔵 CLEAR HISTORY
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Clear History"),
            onTap: () async {
              // you can clear stored data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("History Cleared")),
              );
            },
          ),

          // 🔵 ABOUT APP
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About App"),
            subtitle: const Text("Version 1.0"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text("About App"),
                  content: Text(
                      "Water Quality Assessment App\nVersion 1.0\nDeveloped for Hackathon"),
                ),
              );
            },
          ),

          // 🔵 HELP & SUPPORT
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text("Help & Support"),
            subtitle: const Text("Contact us"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text("Help & Support"),
                  content: Text(
                      "Phone: +91 9876543210\nEmail: support@waterapp.com"),
                ),
              );
            },
          ),


          //about
    ListTile(
    title: const Text("About App"),
    leading: const Icon(Icons.info),
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AboutScreen()),
    );
    },
    ),

          // 🔴 LOGOUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () async {

              await AuthService.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
              );
            },
          ),

        ],
      ),
    );
  }
}