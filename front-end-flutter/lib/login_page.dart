import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _visibilidade = true;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Digite seu email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: _visibilidade,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _visibilidade
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _visibilidade = !_visibilidade;
                          });
                        },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/cadastro'),
                    child: Text(
                      'Não possui uma conta? Faça Cadastro',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: nassauGold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_emailController.text == 'teste@email.com' &&
                          _senhaController.text == '12345') {
                        print('LOGIN REALIZADO COM SUCESSO');
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        print('ACESSO NEGADO');
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Entrar',
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
