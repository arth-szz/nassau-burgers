class Hamburguer {
  final String id;
  final String nome;
  final double preco;

  Hamburguer({required this.id, required this.nome, required this.preco});

  factory Hamburguer.fromJson(Map<String, dynamic> json) {
    return Hamburguer(
      id: json['id'],
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
    );
  }
}