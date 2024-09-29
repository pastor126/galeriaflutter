import 'package:flutter/material.dart';
import 'appbar1.dart';

class OracaoPage extends StatefulWidget {
  final String title;
  const OracaoPage({super.key, required this.title});

  @override
  OracaoPageState createState() => OracaoPageState();
}

class OracaoPageState extends State<OracaoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const AppbarConfig(),
     body: Padding(
  padding: const EdgeInsets.all(20.0),  // Define o padding ao redor de toda a Column
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Oração dos Pastores', style: TextStyle(fontSize: 25,),),
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
            TextSpan(text: '"LIBERTEMO-NOS DAS CORRENTES QUE NOS LIGAM A UMA VIDA POUCO EFICIENTE,\n CAMINHEMOS EM DIREÇÃO AO SABER E AO FAZER,\n',
        style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextSpan(
              text: "-------", // Adiciona o recuo
            ),
            TextSpan(text: 'PREPAREMOS NOSSOS CORPOS PARA DUROS COMBATES E TENHAMOS NOSSAS MENTES ABERTAS PARA ACEITAR ESTA FILOSOFIA DE PROCEDER,',
        style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextSpan(
              text: "\n-------", // Adiciona o recuo
            ),
            TextSpan(text: 'A FIM DE QUE POSSAMOS, ORGULHOSAMENTE, PERTENCER AO CANIL DOS PASTORES ...   PASTOR!!!"',
        style: TextStyle(fontSize: 16, color: Colors.black),
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
