import 'package:flutter/material.dart';
import 'package:nassau_burgers/acompanhamento_page.dart';
import 'package:nassau_burgers/cadastro_page.dart';
import 'package:nassau_burgers/editar_usuario_page.dart';
import 'package:nassau_burgers/gerenciar_pedidos_page.dart';
import 'package:nassau_burgers/gerenciar_usuarios_page.dart';
import 'package:nassau_burgers/pedido_page.dart';
import 'package:nassau_burgers/home_page.dart';
import 'package:nassau_burgers/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/home': (context) => HomePage(),
        '/pedido': (context) => PedidoPage(),
        '/acompanhamento': (context) => AcompanhamentoPage(),
        '/gerenciar-pedidos': (context) => GerenciarPedidosPage(),
        '/gerenciar-usuarios': (context) => GerenciarUsuariosPage(),
        '/editar-usuario': (context) => EditarUsuarioPage(),
      },
    );
  }
}
