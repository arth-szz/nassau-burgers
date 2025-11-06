import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key});

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  String? hamburguerSelecionado;
  bool adicionarBacon = false;
  bool adicionarQueijo = false;
  bool adicionarMolho = false;

  final _quantidade = TextEditingController();


  Widget preco(String? hamburguerSelecionado) {
    if(hamburguerSelecionado == 'HambúrguerReal') {
      return const Text('R\$32,90');
    } else if(hamburguerSelecionado == 'Sertanejo Bacon') {
      return const Text('R\$34,90');
    } else if(hamburguerSelecionado == 'Dourado Supreme') {
      return const Text('R\$38,90');
    } else if(hamburguerSelecionado == 'Ministro Burguer') {
      return const Text('R\$49,99');
    } else if(hamburguerSelecionado == 'Mr. Obesidade') {
      return const Text('R\$100,10');
    } else if(hamburguerSelecionado == 'Entope Artéria') {
      return const Text('R\$149,10');
    } else {
      return const Text('R\$--,--');
    }
  }

  @override
  void dispose(){
    _quantidade.dispose();
    super.dispose();
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
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  SizedBox(
                    width: 400,
                    child: const Text(
                      'Faça seu Pedido',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: hamburguerSelecionado,
                        hint: const Text('Escolha seu hambúrguer'),
                        items: ['HambúrguerReal', 'Sertanejo Bacon', 'Dourado Supreme', 'Ministro Burguer', 'Mr. Obesidade', 'Entope Artéria']
                            .map((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(),
                        onChanged: (String? novoValor) {
                          setState(() {
                            hamburguerSelecionado = novoValor!;
                          });
                        },
                      ),
                      SizedBox(width: 20,),
                      preco(hamburguerSelecionado),
                    ],
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                      title: Text(
                        'Adicionar bacon',
                        style: TextStyle(color: nassauWhite),
                      ),
                      activeColor: nassauGold, // cor dourada
                      checkColor: nassauBlack,
                      value: adicionarBacon,
                      onChanged: (bool? valor) {
                        setState(() {
                          adicionarBacon = valor!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                      title: Text(
                        'Adicionar queijo extra',
                        style: TextStyle(color: nassauWhite),
                      ),
                      activeColor: nassauGold,
                      checkColor: nassauBlack,
                      value: adicionarQueijo,
                      onChanged: (bool? valor) {
                        setState(() {
                          adicionarQueijo = valor!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                      title: Text(
                        'Adicionar molho especial',
                        style: TextStyle(color: nassauWhite),
                      ),
                      activeColor: nassauGold,
                      checkColor: nassauBlack,
                      value: adicionarMolho,
                      onChanged: (bool? valor) {
                        setState(() {
                          adicionarMolho = valor!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _quantidade,
                      decoration: InputDecoration(
                        hintText: 'Quantidade',
                        border: OutlineInputBorder()
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/acompanhamento'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(nassauGold),
                      foregroundColor: WidgetStateProperty.all(nassauBlack),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: const Text(
                      'Finalizar compra',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
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
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart, color: nassauGold),
              title: Text('Fazer pedido'),
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
