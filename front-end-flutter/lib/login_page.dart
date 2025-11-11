import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String senha = '';

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
                  const SizedBox(height: 30),
                  TextField(
                    onChanged: (text) => email = text,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (text) => senha = text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (email == 'teste@email.com' && senha == '12345') {
                        print('LOGIN REALIZADO COM SUCESSO');
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        print('ACESSO NEGADO');
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        child: Text('Entrar', textAlign: TextAlign.center,)
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
