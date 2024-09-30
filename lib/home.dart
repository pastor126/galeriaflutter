import 'package:flutter/material.dart';
import 'appbar1.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const AppbarConfig(),
     body: Padding(
  padding: const EdgeInsets.all(20.0),  // Define o padding ao redor de toda a Column
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Ordem dos Pastores', style: TextStyle(fontSize: 25,),),
      Image.asset(
        'assets/images/Pastor.png', 
        width: 120, 
        height: 120,
      ),  // Imagem
      
      RichText(
        textAlign: TextAlign.justify,
           text: const TextSpan(
            children: [
            TextSpan(
              text: "-------", // Adiciona o recuo
            ),
            TextSpan(text: '"De acordo com a tradição, espera-se que o detentor deste título seja adestrado, amigo, legal, vigilante e se necessário ... agressivo."',
        style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            ],
      ),
      ),
      const SizedBox(height:10,),
        RichText(
        textAlign: TextAlign.justify,
           text: const TextSpan(
            children: [
              TextSpan(
              text: '____________',
            ),
            TextSpan(
              text: 'AVISOS \n', style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            TextSpan(text: 'Aqui poderá encontrar avisos referente à Ordem.',
        style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            ],
      ),
      ),
    ],
  ),
),
    );
  }
}
