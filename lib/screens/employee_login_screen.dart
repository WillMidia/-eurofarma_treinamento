import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class EmployeeLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 120, // Ajusta para centralizar verticalmente
            left: MediaQuery.of(context).size.width / 2 - 150, // Ajusta para centralizar horizontalmente
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 300,  // Define a largura maior
                height: 280,  // Define a altura maior
                child: Image.asset(
                  'assets/images/eurofarma-back.png',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Espaço acima da logo
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/eurofarma-logo.png',
                    width: 200,
                    height: 50,
                  ),
                ),
                // Espaço entre a logo e o título
                SizedBox(height: 40),
                Text(
                  'Login de Funcionário',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Icon(
                  Icons.work,
                  size: 30,
                  color: Colors.blue,
                ),
                // Espaço para ajustar a posição do formulário
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.infinity, // Ocupa toda a largura disponível
                        constraints: BoxConstraints(
                          maxWidth: 400, // Limita a largura máxima
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              hintText: 'LOGIN',
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              hintText: 'SENHA',
                              obscureText: true,
                            ),
                            SizedBox(height: 20), // Ajusta o espaço entre o campo de senha e o botão "Esqueci a senha"
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Esqueci a senha',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue, // Cor de fundo
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                      ),
                                      child: Text(
                                        'ENTRAR',
                                        style: TextStyle(fontSize: 16, color: Colors.white), // Cor do texto
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}