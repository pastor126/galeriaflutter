import 'package:flutter/material.dart';
import 'listapastor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contato.dart';
import 'login.dart';
import 'home.dart';

class OracaoPage extends StatefulWidget {
  const OracaoPage({super.key});

  @override
  OracaoPageState createState() => OracaoPageState();
}

class OracaoPageState extends State<OracaoPage> {
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
        title: const Text('Oração dos Pastores'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'home') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else if (value == 'oracao') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const OracaoPage()),
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
                value: 'oracao',
                child: Text('Oração dos Pastores'),
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
      const Text('Oração dos Pastores', style: TextStyle(fontSize: 30,),),
      Image.asset(
        'assets/images/Pastor.png', 
        width: 100, 
        height: 100,
      ),  // Imagem
      const SizedBox(height: 10),
      RichText(
        textAlign: TextAlign.justify,
           text: const TextSpan(
            children: [
            TextSpan(
              text: "-------", // Adiciona o recuo
            ),
            TextSpan(text: '"LIBERTEMO-NOS DAS CORRENTES QUE NOS LIGAM A UMA VIDA POUCO EFICIENTE,\n CAMINHEMOS EM DIREÇÃO AO SABER E AO FAZER,\n PREPAREMOS NOSSOS CORPOS PARA DUROS COMBATES E TENHAMOS NOSSAS MENTES ABERTAS PARA ACEITAR ESTA FILOSOFIA DE PROCEDER,',
        style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextSpan(
              text: "\n-------", // Adiciona o recuo
            ),
            TextSpan(text: 'A FIM DE QUE POSSAMOS, ORGULHOSAMENTE, PERTENCER AO CANIL DOS PASTORES ...   PASTOR!!!"',
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
