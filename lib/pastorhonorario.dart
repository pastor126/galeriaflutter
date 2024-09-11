import 'listapastor.dart';
import 'package:flutter/material.dart';



class PastorHonorarioPage extends StatelessWidget {
  const PastorHonorarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PastorListPage(isHonorario: true);
  }
}