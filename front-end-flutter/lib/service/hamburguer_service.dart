import 'dart:convert';
import 'package:nassau_burgers/api_constants.dart';
import 'package:nassau_burgers/model/hamburguer_model.dart';
import 'package:http/http.dart' as http;

class HamburguerService {

  Future<List<Hamburguer>> getHamburgueres() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/hamburgueres');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        List<Hamburguer> hamburgueres = body
            .map((dynamic item) => Hamburguer.fromJson(item))
            .toList();

        return hamburgueres;
      } else {
        throw Exception('Falha ao carregar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}