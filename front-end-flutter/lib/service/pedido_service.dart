import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nassau_burgers/model/pedido_model.dart';
import '../api_constants.dart';
import '../session.dart';

class PedidoService {

  Future<void> realizarPedido({
    required String hamburguerId,
    required int quantidade,
    required bool bacon,
    required bool queijo,
    required bool molho,
  }) async {

    final url = Uri.parse('${ApiConstants.baseUrl}/pedidos');

    final usuarioId = Session.currentUser?.id;

    if (usuarioId == null) {
      throw Exception("Usuário não está logado!");
    }

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "usuarioId": usuarioId,
        "hamburguerId": hamburguerId,
        "quantidade": quantidade,
        "bacon": bacon,
        "queijo": queijo,
        "molho": molho,
        "status": "PENDENTE"
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao realizar pedido: ${response.body}');
    }
  }

  Future<List<Pedido>> listarPedidos() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/pedidos');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Pedido.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar pedidos');
    }
  }

  Future<void> atualizarStatus(String pedidoId, String novoStatus) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/pedidos/$pedidoId');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "status": novoStatus
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar status: ${response.body}');
    }
  }
}