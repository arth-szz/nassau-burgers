import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';

class AcompanhamentoPage extends StatefulWidget {
  const AcompanhamentoPage({super.key});

  @override
  State<AcompanhamentoPage> createState() => _AcompanhamentoPageState();
}

class _AcompanhamentoPageState extends State<AcompanhamentoPage> {
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
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  SizedBox(
                    width: 400,
                    child: const Text(
                      'Acompanhamento de Pedidos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    height: 500,
                    width: 325,
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder:(context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Pedido --'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Status:\n-------'),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Sabor --'),
                                        SizedBox(height: 15,),
                                        Text('Quantidade --'),
                                        SizedBox(height: 15,),
                                        Text('Preço R\$--,--'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Extras:'),
                                        SizedBox(height: 15,),
                                        Text('Bacon: --\nQueijo: --\nMolho: --'),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  )
                ],
              ),
            )
          )
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
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
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
            ),
          ],
        ),
      ),
    );
  }
}
