import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/custom_drawer.dart';
import 'package:nassau_burgers/hamburguer_card.dart';
import 'package:nassau_burgers/model/hamburguer_model.dart';
import 'package:nassau_burgers/service/hamburguer_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HamburguerService service = HamburguerService();
  late Future<List<Hamburguer>> futureHamburgueres;

  @override
  void initState() {
    super.initState();
    futureHamburgueres = service.getHamburgueres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "NASSAU BURGERS",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: nassauGold,
              letterSpacing: 2
          ),
        ),
        iconTheme: const IconThemeData(color: nassauGold),
      ),
      extendBodyBehindAppBar: true,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 120, 20, 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xFF121212)],
                ),
              ),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 42, height: 1.2, fontFamily: 'Arial'),
                      children: [
                        TextSpan(
                          text: 'O Sabor Real do\n',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Hambúrguer\n',
                          style: TextStyle(color: nassauGold, fontWeight: FontWeight.w900),
                        ),
                        TextSpan(
                          text: 'de Salvador',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 350,
                    child: Text(
                      'Artesanal. Suculento. Nordestino.\nExperimente a verdadeira revolução do sabor.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/pedido'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: nassauGold,
                      foregroundColor: nassauBlack,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      elevation: 10,
                      shadowColor: nassauGold.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restaurant_menu),
                        SizedBox(width: 10),
                        Text(
                          'FAZER PEDIDO',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.local_fire_department, color: nassauGold),
                        SizedBox(width: 10),
                        Text(
                          'Mais Pedidos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 340,
                    child: FutureBuilder<List<Hamburguer>>(
                      future: futureHamburgueres,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: nassauGold));
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Erro: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
                        } else if (snapshot.hasData) {
                          final lista = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            itemCount: lista.length,
                            itemBuilder: (context, index) {
                              final hamburguer = lista[index];
                              return Container(
                                width: 280,
                                margin: const EdgeInsets.only(right: 20),
                                child: HamburguerCard(
                                  imagePath: 'assets/images/hamburguer.png',
                                  nome: hamburguer.nome,
                                  preco: "R\$ ${hamburguer.preco.toStringAsFixed(2)}",
                                ),
                              );
                            },
                          );
                        }
                        return const Center(child: Text("Nenhum dado encontrado"));
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Sobre Nós',
                    style: TextStyle(color: nassauGold, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Na Nassau Burgers, transformamos ingredientes frescos no verdadeiro sabor do Nordeste. Nossa missão é fazer do simples, algo extraordinário.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
                  ),

                  const Divider(color: Colors.grey, height: 50, thickness: 0.2),

                  const Text(
                    'Contato & Localização',
                    style: TextStyle(color: nassauGold, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Rua dos Maçons, 123 - Salvador, BA',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        '(71) 91234-5678',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Ter a Dom: 18h às 23h',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "© 2025 Nassau Burgers",
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}