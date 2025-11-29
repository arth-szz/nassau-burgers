import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/session.dart'; // Importe a sessão para pegar o usuário

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Session.currentUser;
    final bool isFuncionario = usuario?.isFuncionario ?? false;

    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: Column(
        children: [
          Container(
            height: 120.0,
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            width: double.infinity,
            decoration: const BoxDecoration(color: nassauBlack),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (usuario != null)
                  Text(
                    "Olá, ${usuario.nome}",
                    style: const TextStyle(color: nassauGold, fontSize: 14),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildMenuItem(
                    context,
                    icon: Icons.home,
                    text: 'Início',
                    route: '/home'
                ),
                _buildMenuItem(
                    context,
                    icon: Icons.add_shopping_cart,
                    text: 'Fazer pedido',
                    route: '/pedido'
                ),
                _buildMenuItem(
                    context,
                    icon: Icons.article,
                    text: 'Acompanhamento',
                    route: '/acompanhamento'
                ),

                if (isFuncionario) ...[
                  const Divider(color: Colors.grey),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 10, bottom: 5),
                    child: Text("Administração", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  _buildMenuItem(
                      context,
                      icon: Icons.add_moderator,
                      text: 'Gerenciar Pedidos',
                      route: '/gerenciar-pedidos',
                      color: nassauGold // Destaque dourado
                  ),
                  _buildMenuItem(
                      context,
                      icon: Icons.admin_panel_settings,
                      text: 'Gerenciar Usuários',
                      route: '/gerenciar-usuarios',
                      color: nassauGold
                  ),
                ],
                // -----------------------------------------------------
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: nassauGold),
                label: const Text('Sair', style: TextStyle(color: nassauGold)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: nassauBlack,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    side: const BorderSide(color: nassauGold, width: 1)
                ),
                onPressed: () {
                  Session.currentUser = null;
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String text, required String route, Color color = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: nassauGold),
      title: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}