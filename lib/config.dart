import 'package:flutter/material.dart';
import 'package:galeriaflutter/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer'; 
import 'appbar1.dart';

class ConfigPage extends StatefulWidget {
  final String title;
  const ConfigPage({super.key, required this.title});

  @override
  ConfigPageState createState() => ConfigPageState();
}


class ConfigPageState extends State<ConfigPage> {
  final _senha1Controller = TextEditingController();
  final _senha2Controller = TextEditingController();
 

Future<void> _alteraMensagem() async {
  // Validação dos campos
  var senha1 = _senha1Controller.text;
  var senha2 = _senha2Controller.text;
  if (_senha1Controller.text.isEmpty || 
      senha1 != senha2) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A nova senha e a confirmação devem ser preenchidas e iguais.')),
      );
    }
    return;
  }

  final config = {
    'sen1': _senha1Controller.text,
    'sen2': _senha2Controller.text,
  };
   final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

    if (token == null) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }

  try {
    final response = await http.post(
    // Uri.parse('https://galeria-dos-pastores-production.up.railway.app/atual'),
    Uri.parse('http://192.168.1.74:8089/atual'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', 
    },
    body: jsonEncode(config),
  );
    if (!mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha alterada com sucesso!')),
      );
    } else if (response.statusCode == 401){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verifique a senha atual e tente novamente.')),
      );
    }else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Falha ao alterar a senha. Código de status: ${response.statusCode}')),
  );
}
  } catch (e) {
    log('Erro: $e'); 
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de rede. Tente novamente mais tarde.')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarConfig(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Atualize sua senha.'),
            TextField(
              controller: _senha1Controller,
              decoration: const InputDecoration(labelText: 'Nova Senha'),
              obscureText: true,
            ),
            TextField(
              controller: _senha2Controller,
              decoration: const InputDecoration(labelText: 'Confirme a Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _alteraMensagem,
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}


