import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';

class EditarUsuarioPage extends StatefulWidget {
  const EditarUsuarioPage({super.key});

  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _senhaController.dispose();
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
        iconTheme: IconThemeData(color: nassauGold),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/gerenciar-usuarios');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const SizedBox(
                    width: 400,
                    child: Text(
                      'Editar Usuário',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 38),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Digite seu nome',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _senhaController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para salvar as alterações do usuário
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Editar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: nassauGold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
