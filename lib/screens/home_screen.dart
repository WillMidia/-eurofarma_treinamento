import 'package:flutter/material.dart';
import '../widgets/bottom_nav_screen.dart'; // Certifique-se de importar o novo widget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo da Eurofarma
          SizedBox(height: 25), // Ajuste a altura para mover a logo mais para baixo
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/eurofarma-logo.png',
              width: 200,
              height: 50,
            ),
          ),
          SizedBox(height: 20),
          // Informações do usuário
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome do Usuário', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Cargo', style: TextStyle(fontSize: 16)),
                  Text('Departamento', style: TextStyle(fontSize: 16)),
                  Text('CPF: 123.456.789-00', style: TextStyle(fontSize: 16)),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile_picture.png'),
              ),
            ],
          ),
          SizedBox(height: 1),
          // Espaço flexível para centralizar o balão de fala com o ícone Android
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Balão de fala
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Olá, eu sou o EuroBot! Seja bem-vindo ao app da Eurofarma!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Ícone Android
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[700],
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: const Icon(
                      Icons.android,
                      size: 50,
                      color: Colors.white,
                    ),
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
