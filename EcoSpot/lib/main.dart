import 'package:flutter/material.dart';
import 'role_selection_page.dart';
import 'user_login_screen.dart';
import 'municipality_login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSpot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RoleSelectionPage(),
      routes: {
        '/user_login': (context) => const LoginScreen(),
        '/municipality_login': (context) => const MunicipalityLoginScreen(),
      },
    );
  }
}
