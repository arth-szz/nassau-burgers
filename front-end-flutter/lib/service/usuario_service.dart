import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../model/usuario_model.dart';
import '../session.dart';

class UsuarioService {
  Future<void> cadastrar(String nome, String email, String senha) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/usuarios');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao cadastrar: ${response.body}');
    }
  }


  Future<void> login(String email, String senha) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/usuarios/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      Session.currentUser = Usuario.fromJson(json);
    } else {
      throw Exception('Email ou senha inválidos');
    }
  }

  Future<List<Usuario>> listarTodos() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/usuarios');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Usuario.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }

  Future<void> excluir(String id) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/usuarios/$id');

    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Erro ao excluir usuário');
    }
  }

  Future<void> atualizar(String id, String nome, String email, String? novaSenha) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/usuarios/$id');

    final Map<String, dynamic> dados = {
      "nome": nome,
      "email": email,
    };

    if (novaSenha != null && novaSenha.isNotEmpty) {
      dados["senha"] = novaSenha;
    }

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dados),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar: ${response.body}');
    }
  }
}