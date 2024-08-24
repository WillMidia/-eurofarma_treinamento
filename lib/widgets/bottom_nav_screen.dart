import 'package:flutter/material.dart';

class BottomNavScreen extends StatelessWidget {
  final Widget child; // O conteúdo específico da tela

  BottomNavScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: child), // Conteúdo específico da tela
            // Barra de navegação inferior
            BottomNavigationBar(
              currentIndex: _selectedIndex(context),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Treinamentos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
              onTap: (index) {
                _onItemTapped(index, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    // Lógica para determinar o índice selecionado com base na tela atual
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName == '/training') {
      return 1;
    } else if (routeName == '/profile') {
      return 2;
    }
    return 0; // HomeScreen por padrão
  }

  void _onItemTapped(int index, BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    // Não faz nada se o usuário clicar na página atual
    if ((index == 0 && currentRoute == '/home') ||
        (index == 1 && currentRoute == '/training') ||
        (index == 2 && currentRoute == '/profile')) {
      return;
    }

    switch (index) {
      case 1:
        Navigator.pushReplacementNamed(context, '/training');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      default:
        Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }
}
