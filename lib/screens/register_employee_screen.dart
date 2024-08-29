import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class RegisterEmployeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Funcionário'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 120,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 300,
                height: 280,
                child: Image.asset(
                  'assets/images/eurofarma-back.png',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    hintText: 'Nome Completo',
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Cargo',
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Treinamentos',
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Adicione a funcionalidade de registro aqui
                    },
                    child: Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
