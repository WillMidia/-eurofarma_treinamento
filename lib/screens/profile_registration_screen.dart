import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart'; // Importe o widget personalizado para os campos de texto

class ProfileRegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 120, // Ajusta para centralizar verticalmente
            left: MediaQuery.of(context).size.width / 2 - 150, // Ajusta para centralizar horizontalmente
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 300,  // Define a largura maior
                height: 280,  // Define a altura maior
                child: Image.asset(
                  'assets/images/eurofarma-back.png', // Certifique-se de que o caminho está correto
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/eurofarma-logo.png', // Certifique-se de que o caminho está correto
                        width: 200,
                        height: 50,
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      hintText: 'Nome Completo',
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Email',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Senha',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Confirmar Senha',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'CPF',
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Lógica de cadastro de perfil
                        }
                      },
                      child: Text('Cadastrar Perfil'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
