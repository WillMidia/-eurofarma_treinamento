import 'package:flutter/material.dart';
import '../services/training_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingProgressScreen extends StatelessWidget {
  final String userId;
  final String trainingId;

  TrainingProgressScreen({required this.userId, required this.trainingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progresso do Treinamento')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: TrainingService().getTrainingProgress(userId, trainingId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var progressData = snapshot.data!;
          double progress = progressData['progress'] ?? 0.0;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Progresso: ${(progress * 100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                LinearProgressIndicator(value: progress),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Simular progresso do treinamento
                    TrainingService().updateTrainingProgress(userId, trainingId, progress + 0.1);
                  },
                  child: Text('Avançar 10%'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
