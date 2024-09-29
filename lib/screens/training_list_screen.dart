import 'package:flutter/material.dart';
import '../services/training_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingListScreen extends StatelessWidget {
  final String cargo;

  TrainingListScreen({required this.cargo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Treinamentos Disponíveis')),
      body: StreamBuilder<QuerySnapshot>(
        stream: TrainingService().getTrainingsForCargo(cargo),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var trainings = snapshot.data!.docs;

          if (trainings.isEmpty) {
            return Center(child: Text('Nenhum treinamento disponível para este cargo.'));
          }

          return ListView.builder(
            itemCount: trainings.length,
            itemBuilder: (context, index) {
              var training = trainings[index];

              return ListTile(
                title: Text(training['title']),
                subtitle: Text(training['description']),
                onTap: () {
                  // Adicionar lógica de progresso do treinamento
                },
              );
            },
          );
        },
      ),
    );
  }
}
