import 'package:flutter/material.dart';
import '../widgets/bottom_nav_screen.dart'; // Certifique-se de importar o novo widget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: Stack(
        fit: StackFit.expand, // Expande o Stack para ocupar toda a área disponível
        children: [
          // Imagem de fundo
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.1, // Ajusta a transparência
              child: Container(
                width: 300, // Define a largura da imagem
                height: 300, // Define a altura da imagem
                child: Image.asset(
                  'assets/images/eurofarma-back.png', // Substitua pelo nome correto da imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir o container
                ),
              ),
            ),
          ),
          Column(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'William Tedros',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Gerente de Farmácia',
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Departamento: Farmacologia',
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'CPF: 123.456.789-00',
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/profile_picture.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
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
                      SizedBox(height: 20),
                      // Ícone Android
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[700],
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: const Icon(
                          Icons.android,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
