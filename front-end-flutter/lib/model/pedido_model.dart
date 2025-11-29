class Pedido {
  final String id;
  final String hamburguerId;
  final int quantidade;
  final String status;
  final bool bacon;
  final bool queijo;
  final bool molho;

  Pedido({
    required this.id,
    required this.hamburguerId,
    required this.quantidade,
    required this.status,
    required this.bacon,
    required this.queijo,
    required this.molho,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      hamburguerId: json['hamburguerId'],
      quantidade: json['quantidade'],
      status: json['status'] ?? 'PENDENTE',
      bacon: json['bacon'] ?? false,
      queijo: json['queijo'] ?? false,
      molho: json['molho'] ?? false,
    );
  }
}