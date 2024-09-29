import 'listapastor.dart';
import 'package:flutter/material.dart';



class PastorHonorarioPage extends StatelessWidget {
  final String title;
  const PastorHonorarioPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const PastorListPage(isHonorario: true, title: 'Pastores Honorários');
  }
}