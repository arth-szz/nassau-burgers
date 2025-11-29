import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';
import 'package:nassau_burgers/custom_drawer.dart';
import 'package:nassau_burgers/editar_usuario_page.dart';
import 'package:nassau_burgers/model/usuario_model.dart';
import 'package:nassau_burgers/service/usuario_service.dart';
import 'package:nassau_burgers/session.dart';

class GerenciarUsuariosPage extends StatefulWidget {
  const GerenciarUsuariosPage({super.key});

  @override
  State<GerenciarUsuariosPage> createState() => _GerenciarUsuariosPageState();
}

class _GerenciarUsuariosPageState extends State<GerenciarUsuariosPage> {
  final UsuarioService _service = UsuarioService();
  late Future<List<Usuario>> _futureUsuarios;

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  void _carregarUsuarios() {
    setState(() {
      _futureUsuarios = _service.listarTodos();
    });
  }

  Future<void> _excluirUsuario(String id) async {
    try {
      await _service.excluir(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário excluído com sucesso!"), backgroundColor: Colors.green),
      );
      _carregarUsuarios();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    }
  }

  void _confirmarExclusao(String id, String nome) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text("Excluir Usuário?", style: TextStyle(color: Colors.white)),
        content: Text("Tem certeza que deseja remover $nome?", style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _excluirUsuario(id);
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meuId = Session.currentUser?.id;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Gerenciar Usuários",
          style: TextStyle(fontWeight: FontWeight.bold, color: nassauGold),
        ),
        backgroundColor: nassauBlack,
        iconTheme: const IconThemeData(color: nassauGold),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: FutureBuilder<List<Usuario>>(
          future: _futureUsuarios,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: nassauGold));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
            }

            final lista = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final usuario = lista[index];
                final ehVoceMesmo = usuario.id == meuId;

                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: ehVoceMesmo ? nassauGold.withOpacity(0.5) : Colors.transparent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ehVoceMesmo ? nassauGold : Colors.grey[800],
                          foregroundColor: ehVoceMesmo ? nassauBlack : Colors.white,
                          child: Text(usuario.nome.isNotEmpty ? usuario.nome[0].toUpperCase() : '?'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usuario.nome + (ehVoceMesmo ? " (Você)" : ""),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                usuario.email,
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              if (usuario.isFuncionario)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: nassauGold.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    "ADMIN",
                                    style: TextStyle(color: nassauGold, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditarUsuarioPage(usuario: usuario),
                                  ),
                                );

                                if (result == true) {
                                  _carregarUsuarios();
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                  Icons.delete,
                                  color: ehVoceMesmo ? Colors.grey : Colors.redAccent
                              ),
                              onPressed: ehVoceMesmo
                                  ? null
                                  : () => _confirmarExclusao(usuario.id!, usuario.nome),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}