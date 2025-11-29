class Usuario {
  final String? id;
  final String nome;
  final String email;
  final String? senha;
  final String tipo;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    this.senha,
    this.tipo = 'CLIENTE',
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      tipo: json['tipo'] ?? 'CLIENTE',
    );
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome, 'email': email, 'senha': senha, 'tipo': tipo};
  }

  bool get isFuncionario => tipo == 'ADMIN';
}
