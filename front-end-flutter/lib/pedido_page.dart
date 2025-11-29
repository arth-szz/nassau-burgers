import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/custom_drawer.dart';
import 'package:nassau_burgers/model/hamburguer_model.dart';
import 'package:nassau_burgers/service/hamburguer_service.dart';
import 'package:nassau_burgers/service/pedido_service.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key});

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  // Serviços
  final HamburguerService _hamburguerService = HamburguerService();
  final PedidoService _pedidoService = PedidoService();

  // Estado
  List<Hamburguer> _listaHamburgueres = [];
  Hamburguer? _hamburguerSelecionado;

  bool adicionarBacon = false;
  bool adicionarQueijo = false;
  bool adicionarMolho = false;
  bool _isLoading = false;

  final _quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarCardapio();
  }

  Future<void> _carregarCardapio() async {
    try {
      final lista = await _hamburguerService.getHamburgueres();
      setState(() {
        _listaHamburgueres = lista;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar cardápio: $e")),
      );
    }
  }

  Future<void> _finalizarCompra() async {
    if (_hamburguerSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Selecione um hambúrguer!")));
      return;
    }
    if (_quantidadeController.text.isEmpty ||
        int.tryParse(_quantidadeController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Informe uma quantidade válida!")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _pedidoService.realizarPedido(
        hamburguerId: _hamburguerSelecionado!.id,
        quantidade: int.parse(_quantidadeController.text),
        bacon: adicionarBacon,
        queijo: adicionarQueijo,
        molho: adicionarMolho,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pedido realizado com sucesso!"),
              backgroundColor: Colors.green),
        );
        Navigator.pushReplacementNamed(context, '/acompanhamento');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fundo Dark
      appBar: AppBar(
        backgroundColor: nassauBlack,
        title: const Text(
          "Nassau Burgers",
          style: TextStyle(fontWeight: FontWeight.bold, color: nassauGold),
        ),
        iconTheme: const IconThemeData(color: nassauGold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Faça seu Pedido',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Monte o hambúrguer do seu jeito',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // --- SEÇÃO DO DROPDOWN ---
                _listaHamburgueres.isEmpty
                    ? const Center(
                    child: CircularProgressIndicator(color: nassauGold))
                    : Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: nassauGold, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF1E1E1E), // Fundo do input
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Hamburguer>(
                      value: _hamburguerSelecionado,
                      hint: const Text('Escolha seu hambúrguer',
                          style: TextStyle(color: Colors.grey)),
                      dropdownColor: const Color(0xFF1E1E1E),
                      // Cor do menu aberto
                      icon: const Icon(
                          Icons.arrow_drop_down, color: nassauGold),
                      isExpanded: true,
                      items: _listaHamburgueres.map((Hamburguer item) {
                        return DropdownMenuItem<Hamburguer>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.nome,
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                "R\$ ${item.preco.toStringAsFixed(2)}",
                                style: const TextStyle(color: nassauGold,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Hamburguer? novoValor) {
                        setState(() {
                          _hamburguerSelecionado = novoValor;
                        });
                      },
                    ),
                  ),
                ),

                // --- MOSTRAR PREÇO SELECIONADO GRANDE ---
                if (_hamburguerSelecionado != null) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Valor Unitário: R\$ ${_hamburguerSelecionado!.preco
                          .toStringAsFixed(2)}",
                      style: const TextStyle(color: nassauGold,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],

                const SizedBox(height: 30),
                const Text("Adicionais", style: TextStyle(color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                // --- CHECKBOXES ESTILIZADOS ---
                _buildCustomCheckbox(
                    "Adicionar Bacon Crocante", adicionarBacon, (val) =>
                    setState(() => adicionarBacon = val!)),
                _buildCustomCheckbox(
                    "Queijo Cheddar Extra", adicionarQueijo, (val) =>
                    setState(() => adicionarQueijo = val!)),
                _buildCustomCheckbox(
                    "Molho Especial da Casa", adicionarMolho, (val) =>
                    setState(() => adicionarMolho = val!)),

                const SizedBox(height: 30),

                // --- INPUT QUANTIDADE ---
                TextField(
                  controller: _quantidadeController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: nassauGold, width: 2),
                    ),
                    prefixIcon: const Icon(
                        Icons.shopping_bag_outlined, color: nassauGold),
                  ),
                ),

                const SizedBox(height: 40),

                // --- BOTÃO FINALIZAR ---
                _isLoading
                    ? const Center(
                    child: CircularProgressIndicator(color: nassauGold))
                    : ElevatedButton(
                  onPressed: _finalizarCompra,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: nassauGold,
                    foregroundColor: nassauBlack,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'FINALIZAR PEDIDO',
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _buildCustomCheckbox(String titulo, bool valor,
      Function(bool?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: valor ? nassauGold : Colors.transparent),
      ),
      child: CheckboxListTile(
        title: Text(titulo,
            style: TextStyle(color: valor ? Colors.white : Colors.grey[400])),
        activeColor: nassauGold,
        checkColor: nassauBlack,
        value: valor,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
