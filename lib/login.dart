import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:galeriaflutter/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'novousuario.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 Future<void> login() async {
  try {
    final response = await http.post(
      Uri.parse('https://galeria-dos-pastores-production.up.railway.app/auth/login'),
      headers: {'Content-Type': 'application/json; charset=UTF-8',},
  body: jsonEncode({
    'username': usernameController.text,
    'password': passwordController.text,
  }),
);
if (!mounted) return;

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage(title: 'Galeria dos Pastores')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha no login. Verifique suas credenciais.')),
      );
    }
  } catch (e) {
    log("Erro durante o login: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro de rede. Tente novamente mais tarde.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  resizeToAvoidBottomInset: true,
  appBar: AppBar(
    title: const Text('Galeria dos Pastores'), centerTitle: true,
  ),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(35),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Pastor.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(height: 20),
        const Text(
          'Login',
          style: TextStyle(fontSize: 22),
        ),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: 'Usuário'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Senha'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        // Botão para efetivar o login.
        ElevatedButton(
          onPressed: login,
          child: const Text('Entrar'),
        ),
        const SizedBox(height: 20),
            // Adiciona um link para a página de cadastro
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterPage()), // Direciona para a página de cadastro
                );
              },
              child: const Text('Criar novo usuário', style: TextStyle(color: Colors.blue, fontSize: 16)),
            ),
      ],
    ),
  ),
);
  }
}
