class Pastor {
  final int id;
  final String numero;
  final String? nome;
  final String iniciais;

  Pastor({required this.id, required this.numero, this.nome, required this.iniciais});

  factory Pastor.fromJson(Map<String, dynamic> json) {
    return Pastor(
      id: json['id'],
      numero: json['numero'],
      nome: json['nome'],
      iniciais: json['iniciais'],
    );
  }
}