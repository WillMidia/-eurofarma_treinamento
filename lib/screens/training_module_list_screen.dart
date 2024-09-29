import 'package:flutter/material.dart';

class TrainingModuleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Módulos de Treinamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Módulo 1: Introdução à Farmácia'),
              onTap: () {
                // Navegar para o detalhe do módulo
              },
            ),
            ListTile(
              title: Text('Módulo 2: Manipulação de Medicamentos'),
              onTap: () {
                // Navegar para o detalhe do módulo
              },
            ),
            // Adicione mais ListTiles conforme necessário
          ],
        ),
      ),
    );
  }
}
