import 'package:eurofarma_treinamento/screens/training_screen.dart';
import 'package:flutter/material.dart';
import '../data/training_data.dart';

class TrainingDetailsScreen extends StatelessWidget {
  final String trainingTitle;
  final VoidCallback onComplete;
  final String userId;

  TrainingDetailsScreen({
    required this.trainingTitle,
    required this.onComplete,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // Obtém os dados do treinamento com base no título
    final trainingDataEntry = trainingData.values.expand((modules) => modules).firstWhere((module) => module['title'] == trainingTitle);

    return Scaffold(
      appBar: AppBar(
        title: Text(trainingTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              trainingTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              trainingDataEntry['content'] ?? 'Conteúdo não disponível',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conteúdo do Curso:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              trainingDataEntry['courseContent'] ?? 'Conteúdo não disponível',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onComplete(); // Chama a função para marcar o módulo como concluído
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
