import 'pastor.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'appbar1.dart';


class PastorListPage extends StatefulWidget {
  final bool isHonorario;
  final String title;
  const PastorListPage({super.key, this.isHonorario = false, required this.title});

  @override
  PastorListPageState createState() => PastorListPageState();
}

class PastorListPageState extends State<PastorListPage> {
  List<Pastor> pastores = [];
  String searchQuery = '';

 
  @override
  void initState() {
    super.initState();
    fetchPastores();
  }

  Future<void> fetchPastores() async {
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
      final url = widget.isHonorario
          ? 'https://galeria-dos-pastores-production.up.railway.app/pastoresHonorarios'
          : 'https://galeria-dos-pastores-production.up.railway.app/pastores';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        String utf8Body = utf8.decode(response.bodyBytes);
        List<dynamic> data = json.decode(utf8Body);
        setState(() {
          pastores = data.map((json) => Pastor.fromJson(json)).toList();
        });
      } else if (response.statusCode == 401) {
        await prefs.remove('token');
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        throw Exception('Falha ao carregar pastores');
      }
    } catch (e) {
    if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de rede. Tente novamente mais tarde.')),
      );
    }
  }

  List<Pastor> get filteredPastores {
    return pastores.where((pastor) {
      final nomeValido = (pastor.nome != null && pastor.nome!.isNotEmpty) ? pastor.nome! : pastor.iniciais;
      return nomeValido.toLowerCase().contains(searchQuery.toLowerCase()) ||
             pastor.numero.contains(searchQuery);
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarConfig(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPastores.length,
              itemBuilder: (context, index) {
                final pastor = filteredPastores[index];
                return ListTile(
                  title: Text(widget.isHonorario ? 'Pastor Honorário ${pastor.numero}' : 'Pastor ${pastor.numero}'),
                  subtitle: Text(pastor.nome ?? pastor.iniciais),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
