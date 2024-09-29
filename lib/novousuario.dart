import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:galeriaflutter/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> register() async {
    const String apiUrl = 'https://galeria-dos-pastores-production.up.railway.app/usuario';

    try {
      // Cria o payload com os dados do usuário
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nome': nameController.text,
          'login': usernameController.text,
          'email': emailController.text,
          'senha': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Exibe mensagem de sucesso e redireciona para login
      if (!mounted) return; // Verifica se o widget ainda está montado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verifique sua caixa de e-mail para validar o cadastro.'),
            duration: Duration(seconds: 6),
          ),
        );

        // Aguarda 3 segundos e redireciona para a página de login
        await Future.delayed(const Duration(seconds: 3));

        // Redireciona para a página de login
        if (!mounted) return; // Verifica se o widget ainda está montado
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        if (!mounted) return; // Verifica se o widget ainda está montado
        // Se houver erro, exibe uma mensagem
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao cadastrar. Tente novamente.'),
          ),
        );
      }
    } catch (e) {
      // Caso ocorra um erro na conexão ou outro problema
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de rede. Tente novamente mais tarde.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de usuário'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cadastrar',
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
              TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: register,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
