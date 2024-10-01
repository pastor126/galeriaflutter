import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:galeriaflutter/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'novousuario.dart';
// google
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Banner google
  BannerAd? _anchoredAdaptiveAd; // Banner que será exibido
  bool _isLoaded = false; // Verifica se o banner foi carregado

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd(); // Carrega o banner ao carregar a página
  }

   Future<void> _loadAd() async {
    // Obtém o tamanho do banner adaptativo com base na largura da tela
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    // Inicializa o banner com o ID de teste (substitua pelo seu ao usar em produção)
    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd; // Armazena o banner carregado
            _isLoaded = true; // Indica que o banner foi carregado
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );

    // Carrega o banner
    return _anchoredAdaptiveAd!.load();
  }


 Future<void> login() async {
  try {
    final response = await http.post(
      Uri.parse('https://galeria-dos-pastores-production.up.railway.app/auth/login'),
      // Uri.parse('http://192.168.1.74:8089/auth/login'),
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

            // Exibe o banner apenas se ele foi carregado (_isLoaded = true)
        if (_anchoredAdaptiveAd != null && _isLoaded)
          Container(
            color: Colors.green,
            width: _anchoredAdaptiveAd!.size.width.toDouble(),
            height: _anchoredAdaptiveAd!.size.height.toDouble(),
            child: AdWidget(ad: _anchoredAdaptiveAd!),
          ),
      ],
    ),
  ),
);
  }
}
