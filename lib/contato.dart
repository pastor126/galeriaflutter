import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'appbar1.dart';
// google
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class FaleComigoPage extends StatefulWidget {
  final String title;
  const FaleComigoPage({super.key, required this.title});

  @override
  FaleComigoPageState createState() => FaleComigoPageState();
}

class FaleComigoPageState extends State<FaleComigoPage> {
  final _telefoneController = TextEditingController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _mensagemController = TextEditingController();

   final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //Banner google
  BannerAd? _anchoredAdaptiveAd; // Banner que será exibido
  bool _isLoaded = false; // Verifica banner foi carregado


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd(); // Carrega o banner ao carregar a página
  }


   Future<void> _loadAd() async {
    // Obtém o tamanho do banner com base na largura da tela
    final AnchoredAdaptiveBannerAdSize? size =
 await     AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());


    if (size == null) {return;}


    //ID de teste (substitua pelo seu ao usar em produção)
    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true; 
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


  Future<void> _enviarMensagem() async {
  // Validação dos campos
  if (_nomeController.text.isEmpty || 
      _telefoneController.text.isEmpty || 
      _emailController.text.isEmpty || 
      _mensagemController.text.isEmpty) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
    return;
  }

  final falaComigo = {
    'telefone': _telefoneController.text,
    'nome': _nomeController.text,
    'email': _emailController.text,
    'mensagem': _mensagemController.text,
  };

  try {
      final response = await http.post(
      Uri.parse('https://galeria-dos-pastores-production.up.railway.app/falecomigo'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(falaComigo),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensagem enviada com sucesso!'),
         duration: Duration(seconds: 6),),
      );

    } else if (response.statusCode == 401){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de autenticação. Por favor, faça login novamente.')),
      );
    }else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Falha ao enviar a mensagem. Código de status: ${response.statusCode}')),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 15),
            const Text('Mensagem'), 
            TextField(
              controller: _mensagemController,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviarMensagem,
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 15,),
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
