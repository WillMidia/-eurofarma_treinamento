import 'package:flutter/material.dart';

class TrainingDetailsScreen extends StatelessWidget {
  final String trainingTitle;
  final VoidCallback onComplete;
  final String userId; // Adiciona o userId aqui

  TrainingDetailsScreen({
    required this.trainingTitle,
    required this.onComplete,
    required this.userId, // Recebe o userId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trainingTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainingTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Conteúdo do treinamento...',
              style: TextStyle(fontSize: 16),
            ),
            // Adicione o conteúdo do treinamento aqui

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onComplete(); // Chama a função para marcar o módulo como concluído
                // Agora retorna à TrainingScreen
                Navigator.pop(context); // Volta para a TrainingScreen
              },
              child: Text('Concluir Módulo'),
            ),
          ],
        ),
      ),
    );
  }
}
