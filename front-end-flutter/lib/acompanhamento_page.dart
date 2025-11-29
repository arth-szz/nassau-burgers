import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/custom_drawer.dart';
import 'package:nassau_burgers/model/hamburguer_model.dart';
import 'package:nassau_burgers/model/pedido_model.dart';
import 'package:nassau_burgers/service/hamburguer_service.dart';
import 'package:nassau_burgers/service/pedido_service.dart';

class AcompanhamentoPage extends StatefulWidget {
  const AcompanhamentoPage({super.key});

  @override
  State<AcompanhamentoPage> createState() => _AcompanhamentoPageState();
}

class _AcompanhamentoPageState extends State<AcompanhamentoPage> {
  final PedidoService _pedidoService = PedidoService();
  final HamburguerService _hamburguerService = HamburguerService();

  late Future<List<Pedido>> _futurePedidos;
  late Future<List<Hamburguer>> _futureHamburgueres;

  @override
  void initState() {
    super.initState();
    _futurePedidos = _pedidoService.listarPedidos();
    _futureHamburgueres = _hamburguerService.getHamburgueres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nassau Burgers",
          style: TextStyle(fontWeight: FontWeight.bold, color: nassauGold),
        ),
        iconTheme: const IconThemeData(color: nassauGold),
        backgroundColor: nassauBlack,
      ),
      backgroundColor: const Color(0xFF121212),

      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([_futurePedidos, _futureHamburgueres]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: nassauGold));
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("Erro ao carregar: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white)),
              );
            }

            // Dados carregados com sucesso!
            final List<Pedido> pedidos = snapshot.data![0];
            final List<Hamburguer> cardapio = snapshot.data![1];

            if (pedidos.isEmpty) {
              return const Center(
                child: Text("Você ainda não fez nenhum pedido.",
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Acompanhamento de Pedidos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pedidos.length,
                    itemBuilder: (context, index) {
                      final pedido = pedidos[pedidos.length - 1 - index];

                      final hamburguer = cardapio.firstWhere(
                            (h) => h.id == pedido.hamburguerId,
                        orElse: () => Hamburguer(id: '', nome: 'Desconhecido', preco: 0.0),
                      );

                      return _buildPedidoCard(pedido, hamburguer);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _buildPedidoCard(Pedido pedido, Hamburguer hamburguer) {

    double total = hamburguer.preco * pedido.quantidade;

    Color statusColor;
    switch (pedido.status) {
      case 'APROVADO': statusColor = Colors.greenAccent; break;
      case 'CANCELADO': statusColor = Colors.redAccent; break;
      case 'ENTREGUE': statusColor = Colors.blueAccent; break;
      default: statusColor = nassauGold;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pedido", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(
                    "#${pedido.id.substring(0, 8)}",
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Status", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(
                    pedido.status,
                    style: TextStyle(color: statusColor, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.grey, height: 30, thickness: 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoLabel("Sabor", hamburguer.nome),
                  const SizedBox(height: 12),
                  _infoLabel("Quantidade", "${pedido.quantidade}x"),
                  const SizedBox(height: 12),
                  _infoLabel("Preço Total", "R\$ ${total.toStringAsFixed(2)}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Extras:", style: TextStyle(color: Colors.white, fontSize: 14)),
                  const SizedBox(height: 8),
                  _extraItem("Bacon", pedido.bacon),
                  _extraItem("Queijo", pedido.queijo),
                  _extraItem("Molho", pedido.molho),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoLabel(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label --", style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _extraItem(String nome, bool ativo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        "$nome: ${ativo ? 'Sim' : 'Não'}",
        style: TextStyle(
          color: ativo ? nassauGold : Colors.grey,
          fontSize: 13,
        ),
      ),
    );
  }
}

