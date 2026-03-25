import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/user_service.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String imagePath = "";

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      await UserService.saveImage(picked.path);

      setState(() {
        imagePath = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: FutureBuilder<Map<String, String>>(
        future: UserService.getUser(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          String name = "User";
          String email = "No Email";
          String loginDate = "";

          if (snapshot.hasData && snapshot.data != null) {
            name = snapshot.data!["name"] ?? "User";
            email = snapshot.data!["email"] ?? "No Email";
            loginDate = snapshot.data!["loginDate"] ?? "";
            imagePath = snapshot.data!["image"] ?? "";
          }

          return SingleChildScrollView(
            child: Column(
              children: [

                // 🔵 TOP SECTION
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),

                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: pickImage,
                        child: Stack(
                          children: [

                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              backgroundImage: imagePath.isNotEmpty
                                  ? FileImage(File(imagePath))
                                  : null,
                              child: imagePath.isEmpty
                                  ? const Icon(Icons.person, size: 60)
                                  : null,
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.black,
                                child: const Icon(Icons.camera_alt,
                                    size: 18, color: Colors.white),
                              ),
                            )

                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        name.isNotEmpty ? name : "User",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        email.isNotEmpty ? email : "No Email",
                        style: const TextStyle(color: Colors.white70),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 🔵 DETAILS CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,

                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Column(
                        children: [

                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Name"),
                            subtitle: Text(name),
                          ),

                          const Divider(),

                          ListTile(
                            leading: const Icon(Icons.email),
                            title: const Text("Email"),
                            subtitle: Text(email),
                          ),

                          const Divider(),

                          ListTile(
                            leading: const Icon(Icons.access_time),
                            title: const Text("Login Date"),
                            subtitle: Text(loginDate),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔵 BUTTONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Profile"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditProfileScreen()),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                          onPressed: () async {
                            await UserService.logout();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LoginScreen()),
                                  (route) => false,
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}