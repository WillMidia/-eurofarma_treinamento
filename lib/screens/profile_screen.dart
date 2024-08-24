import 'package:flutter/material.dart';
import '../widgets/bottom_nav_screen.dart'; // Certifique-se de importar o novo widget
import 'user_selection_screen.dart'; // Certifique-se de que este import está correto

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Foto de perfil
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_picture.png'),
              ),
            ),
            SizedBox(height: 20),
            // Informações do usuário
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Nome do Usuário',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Cargo: Gerente de Farmácia',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Departamento: Farmacologia',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'CPF: 123.456.789-00',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
            // Botão para editar perfil
            ElevatedButton(
              onPressed: () {
                // Adicione a funcionalidade de edição de perfil aqui
              },
              child: Text('Editar Perfil'),
            ),
            SizedBox(height: 20),
            // Botão para sair
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserSelectionScreen(),
                  ),
                      (route) => false,
                );
              },
              child: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
