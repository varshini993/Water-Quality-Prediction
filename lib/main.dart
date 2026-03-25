import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'services/user_service.dart';

ValueNotifier<bool> isDarkMode = ValueNotifier(false);

void main() {
  runApp(const WaterQualityApp());
}

class WaterQualityApp extends StatelessWidget {
  const WaterQualityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value ? ThemeData.dark() : ThemeData.light(),

          home: FutureBuilder<bool>(
            future: UserService.isLoggedIn(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              return snapshot.data == true
                  ? DashboardScreen()
                  : LoginScreen();
            },
          ),
        );
      },
    );
  }
}