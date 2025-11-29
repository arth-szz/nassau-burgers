import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/custom_drawer.dart';
import 'package:nassau_burgers/model/hamburguer_model.dart';
import 'package:nassau_burgers/model/pedido_model.dart';
import 'package:nassau_burgers/service/hamburguer_service.dart';
import 'package:nassau_burgers/service/pedido_service.dart';

class GerenciarPedidosPage extends StatefulWidget {
  const GerenciarPedidosPage({super.key});

  @override
  State<GerenciarPedidosPage> createState() => _GerenciarPedidosPageState();
}

class _GerenciarPedidosPageState extends State<GerenciarPedidosPage> {
  final PedidoService _pedidoService = PedidoService();
  final HamburguerService _hamburguerService = HamburguerService();

  late Future<List<Pedido>> _futurePedidos;
  late Future<List<Hamburguer>> _futureHamburgueres;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    setState(() {
      _futurePedidos = _pedidoService.listarPedidos();
      _futureHamburgueres = _hamburguerService.getHamburgueres();
    });
  }

  Future<void> _alterarStatus(String id, String novoStatus) async {
    try {
      await _pedidoService.atualizarStatus(id, novoStatus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pedido $novoStatus com sucesso!"),
          backgroundColor: novoStatus == 'APROVADO' ? Colors.green : Colors.red,
        ),
      );
      _carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Gerenciar Pedidos",
          style: TextStyle(fontWeight: FontWeight.bold, color: nassauGold),
        ),
        backgroundColor: nassauBlack,
        iconTheme: const IconThemeData(color: nassauGold),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([_futurePedidos, _futureHamburgueres]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: nassauGold));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
            }

            final List<Pedido> pedidos = snapshot.data![0];
            final List<Hamburguer> cardapio = snapshot.data![1];

            pedidos.sort((a, b) {
              if (a.status == 'PENDENTE' && b.status != 'PENDENTE') return -1;
              if (a.status != 'PENDENTE' && b.status == 'PENDENTE') return 1;
              return 0;
            });

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                final hamburguer = cardapio.firstWhere(
                      (h) => h.id == pedido.hamburguerId,
                  orElse: () => Hamburguer(id: '', nome: 'Item Removido', preco: 0),
                );

                return _buildAdminCard(pedido, hamburguer);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildAdminCard(Pedido pedido, Hamburguer hamburguer) {
    bool isPendente = pedido.status == 'PENDENTE';
    Color statusColor;
    switch (pedido.status) {
      case 'APROVADO': statusColor = Colors.green; break;
      case 'CANCELADO': statusColor = Colors.red; break;
      default: statusColor = nassauGold;
    }
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isPendente ? nassauGold.withOpacity(0.5) : Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#${pedido.id.substring(0, 8)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    pedido.status,
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hamburguer.nome,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Qtd: ${pedido.quantidade} | R\$ ${(hamburguer.preco * pedido.quantidade).toStringAsFixed(2)}",
                        style: const TextStyle(color: nassauGold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (pedido.bacon) const Text("+ Bacon", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    if (pedido.queijo) const Text("+ Queijo", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    if (pedido.molho) const Text("+ Molho", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            if (isPendente)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text("APROVAR"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _alterarStatus(pedido.id, "APROVADO"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: const Text("RECUSAR"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _alterarStatus(pedido.id, "CANCELADO"),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}