import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flora_emosens/screens/splash_screen.dart';
import 'package:flora_emosens/screens/register_screen.dart';
import 'package:flora_emosens/screens/login_screen.dart';
import 'package:flora_emosens/screens/home_screen.dart'; // Add home screen
import 'package:flora_emosens/providers/plant_provider.dart';
import 'package:flora_emosens/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlantProvider(),
      child: MaterialApp(
        title: 'Flora EmoSens',
        theme: AppTheme.lightTheme,
        initialRoute: '/register', // Set the initial route
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(), // Add home screen route
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}