import 'package:flutter/material.dart';
import 'login.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria dos Pastores',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.orange, // Define a cor do texto dos ElevatedButtons
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange, // Definindo cor de fundo do AppBar
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white), // Cor dos ícones no AppBar
          
        ),
      ),
      home: const LoginPage(),
     
      debugShowCheckedModeBanner: false,
    );
  }
}



