import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Define a cor do texto dos ElevatedButtons
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // Definindo cor de fundo do AppBar
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



