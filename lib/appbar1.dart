import 'package:flutter/material.dart';
import 'home.dart';
import 'oracao.dart';
import 'listapastor.dart';
import 'config.dart';
import 'contato.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// google
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

// Cria um ValueNotifier para o título da AppBar
ValueNotifier<String> appBarTitleNotifier = ValueNotifier<String>(''); 

// Classe abstrata para a AppBar
abstract class Appbar1 extends StatefulWidget {
  const Appbar1({super.key});
  
  @override
  State<Appbar1> createState() => _Appbar1State();
}

class _Appbar1State extends State<Appbar1> {
 //Google Interstitial
InterstitialAd? _interstitialAd;
// replace this test ad unit with your own ad unit
  final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';

  /// Loads an interstitial ad.
  void loadAd() {
        InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
             ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

@override
void initState() {
  super.initState();
  loadAd(); // Carregar o anúncio ao inicializar a página
}



  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ValueListenableBuilder<String>(
        valueListenable: appBarTitleNotifier,
        builder: (context, title, child) {
          return Text(title);
        },
      ),
      actions: _buildPopupMenu(context),
    );
  }

  List<Widget> _buildPopupMenu(BuildContext context) {
    return [
      PopupMenuButton<String>(
        onSelected: (value) => _onMenuSelected(value, context),
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'home', child: Text('Home')),
          const PopupMenuItem(value: 'oracao', child: Text('Oração dos Pastores')),
          const PopupMenuItem(value: 'pastores', child: Text('Pastores')),
          const PopupMenuItem(value: 'pastoresHonorarios', child: Text('Pastores Honorários')),
          const PopupMenuItem(value: 'falecomigo', child: Text('Fala Comigo')),
          const PopupMenuItem(value: 'atual', child: Text('Gerênciar senha')),
          const PopupMenuItem(value: 'sair', child: Text('Sair')),
        ],
      ),
    ];
  }

  void _onMenuSelected(String value, BuildContext context) {
    String novoTitulo = '';

    switch (value) {
      case 'home':
        novoTitulo = 'Galeria dos Pastores';  
        break;
      case 'oracao':
        novoTitulo = 'Vamos orar!';  
          if (_interstitialAd != null) {
        _interstitialAd!.show(); // Mostra o anúncio
        _interstitialAd = null; // Limpa a referência para garantir que um novo seja carregado
        loadAd(); // Recarrega um novo anúncio para a próxima vez
      }
        break;
      case 'pastores':
        novoTitulo = 'Pastores';
        break;
      case 'pastoresHonorarios':
        novoTitulo = 'Pastores Honorários';
        // Exibir o anúncio intersticial ao selecionar "Pastores"
      if (_interstitialAd != null) {
        _interstitialAd!.show(); // Mostra o anúncio
        _interstitialAd = null; // Limpa a referência para garantir que um novo seja carregado
        loadAd(); // Recarrega um novo anúncio para a próxima vez
      }
        break;
      case 'falecomigo':
        novoTitulo = 'Fala Comigo';
          if (_interstitialAd != null) {
        _interstitialAd!.show(); // Mostra o anúncio
        _interstitialAd = null; // Limpa a referência para garantir que um novo seja carregado
        loadAd(); // Recarrega um novo anúncio para a próxima vez
      }
        break;
      case 'atual':
        novoTitulo = 'Configuração';
          if (_interstitialAd != null) {
        _interstitialAd!.show(); // Mostra o anúncio
        _interstitialAd = null; // Limpa a referência para garantir que um novo seja carregado
        loadAd(); // Recarrega um novo anúncio para a próxima vez
      }
        break;
      case 'sair':
        _logout(context);
        return;
    }

    // Atualiza o título da AppBar
    appBarTitleNotifier.value = novoTitulo;

    // Navega para a nova página
    _navigateToPage(value, context);
  }

  void _navigateToPage(String value, BuildContext context) {
    switch (value) {
      case 'home':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(title: appBarTitleNotifier.value)));
        break;
      case 'oracao':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OracaoPage(title: appBarTitleNotifier.value)));
        break;
      case 'pastores':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PastorListPage(title: appBarTitleNotifier.value)));
        break;
      case 'pastoresHonorarios':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PastorListPage(isHonorario: true, title: appBarTitleNotifier.value)));
        break;
      case 'falecomigo':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FaleComigoPage(title: appBarTitleNotifier.value)));
        break;
      case 'atual':
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ConfigPage(title: appBarTitleNotifier.value)));
        break;
    }
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    if (!mounted) return;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

class AppbarConfig extends Appbar1 implements PreferredSizeWidget {
  const AppbarConfig({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Configuração'),
      actions: _buildPopupMenu(context),
    );
  }

  List<PopupMenuEntry<String>> _buildPopupMenu(BuildContext context) {
    return [
      const PopupMenuItem(value: 'home', child: Text('Home')),
      const PopupMenuItem(value: 'oracao', child: Text('Oração dos Pastores')),
      const PopupMenuItem(value: 'pastores', child: Text('Pastores')),
      const PopupMenuItem(value: 'pastoresHonorarios', child: Text('Pastores Honorários')),
      const PopupMenuItem(value: 'falecomigo', child: Text('Fala Comigo')),
      const PopupMenuItem(value: 'atual', child: Text('Gerênciar senha')),
      const PopupMenuItem(value: 'sair', child: Text('Sair')),
    ];
  }
}

