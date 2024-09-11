import 'package:flutter/material.dart';
import 'listapastor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contato.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Galeria dos Pastores'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'home') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else if (value == 'pastores') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PastorListPage()),
                );
              } else if (value == 'pastoresHonorarios') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PastorListPage(isHonorario: true)),
                );
              } else if (value == 'falecomigo') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const FaleComigoPage()),
                );
              } else if (value == 'sair') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'home',
                child: Text('Home'),
              ),
              const PopupMenuItem(
                value: 'pastores',
                child: Text('Pastores'),
              ),
              const PopupMenuItem(
                value: 'pastoresHonorarios',
                child: Text('Pastores Honorários'),
              ),
              const PopupMenuItem(
                value: 'falecomigo',
                child: Text('Fala Comigo'),
              ),
              const PopupMenuItem(
                value: 'sair',
                child: Text('Sair'),
              ),
            ],
          ),
        ],
      ),
     body: Padding(
  padding: const EdgeInsets.all(20.0),  // Define o padding ao redor de toda a Column
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Ordem dos Pastores', style: TextStyle(fontSize: 30,),),
      Image.asset(
        'assets/images/Pastor.png', 
        width: 120, 
        height: 120,
      ),  // Imagem
      const SizedBox(height: 10),
      RichText(
        textAlign: TextAlign.justify,
           text: const TextSpan(
            children: [
            TextSpan(
              text: "-------", // Adiciona o recuo
            ),
            TextSpan(text: '"De acordo com a tradição, espera-se que o detentor deste título seja amigo, legal, vigilante e, se necessário ... agressivo."',
        style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            ],
          // Centraliza o texto
      ),
      ),
    ],
  ),
),
    );
  }
}
