import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/hamburguer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _inicioKey = GlobalKey();
  final GlobalKey _cardapioKey = GlobalKey();
  final GlobalKey _sobreKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((_) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nassau Burgers",
          style: TextStyle(fontWeight: FontWeight.bold, color: nassauGold),
        ),
        iconTheme: IconThemeData(
          color: nassauGold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 40,),
                SizedBox(
                  width: 400,
                  child: const Text(
                    'O Sabor Real\ndo Hambúrguer\nde Salvador',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: const Text(
                    'Experimente o hambúrguer artesanal com ingredientes selecionados e toque nordestino',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/pedido'),
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(nassauGold),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    side: WidgetStateProperty.all(
                      const BorderSide(color: nassauGold, width: 1.5),
                    ),
                  ),
                  child: const Text(
                    'Fazer Pedido',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      'Cardápio',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: const [
                      HamburguerCard(
                        imagePath: 'assets/images/hamburguer-transparente.png',
                        nome: 'Hambúrguer Real',
                        preco: 'R\$32,90',
                      ),
                      SizedBox(width: 20),
                      HamburguerCard(
                        imagePath: 'assets/images/hamburguer-transparente.png',
                        nome: 'Sertanejo Bacon',
                        preco: 'R\$34,90',
                      ),
                      SizedBox(width: 20),
                      HamburguerCard(
                        imagePath: 'assets/images/hamburguer-transparente.png',
                        nome: 'Dourado Supreme',
                        preco: 'R\$38,90',
                      ),
                      SizedBox(width: 20),
                      HamburguerCard(
                        imagePath: 'assets/images/hamburguer-transparente.png',
                        nome: 'Ministro Burguer',
                        preco: 'R\$49,99',
                      ),
                      SizedBox(width: 20),
                      HamburguerCard(
                        imagePath: 'assets/images/hamburguer-transparente.png',
                        nome: 'Mr. Obesidade',
                        preco: 'R\$100,10',
                      ),
                      SizedBox(width: 20),
                      HamburguerCard(
                        imagePath: 'assets/images/hamburguer-transparente.png',
                        nome: 'Entope Artéria',
                        preco: 'R\$149,10',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  key: _sobreKey,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Sobre nós',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Na Nassau Burgers cada receita à mão com ingredientes frescos e o verdadeiro sabor do Nordeste. Nosso objetivo é proporcionar uma experiência gastronômica inesquecível - onde o simples vira extraodinário.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  key: _contatoKey,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Contato',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Rua dos Maçons, 123, Salvador, BA',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '(71) 91234-5678',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0,
              padding: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(color: nassauBlack),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: nassauGold),
              title: Text('Início'),
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart, color: nassauGold),
              title: Text('Fazer pedido'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/pedido');
              },
            ),
            ListTile(
              leading: Icon(Icons.article, color: nassauGold),
              title: Text('Acompanhamento'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/acompanhamento');
              },
            ),
          ],
        ),
      ),
    );
  }
}
