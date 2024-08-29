import 'package:flutter/material.dart';
import '../widgets/bottom_nav_screen.dart'; // Certifique-se de importar o novo widget
import 'user_selection_screen.dart'; // Certifique-se de que este import está correto

class ProfileScreen extends StatelessWidget {
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
                width: 300, // Define a largura menor da imagem
                height: 300, // Define a altura menor da imagem
                child: Image.asset(
                  'assets/images/eurofarma-back.png', // Substitua pelo nome correto da imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir o container
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Foto de perfil
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/profile_picture.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(height: 20),
                // Informações do usuário
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'William Tedros',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cargo: Gerente de Farmácia',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Departamento: Farmacologia',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'CPF: 123.456.789-00',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                // Botão para editar perfil
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione a funcionalidade de edição de perfil aqui
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                // Botão para sair
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserSelectionScreen(),
                        ),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                    child: Text(
                      'Sair',
                      style: TextStyle(fontSize: 18),
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
