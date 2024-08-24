import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  final List<String> trainings = [
    'Treinamento 1',
    'Treinamento 2',
    'Treinamento 3',
    // Adicione mais treinamentos conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treinamentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: trainings.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(trainings[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingDetailsScreen(
                        trainingTitle: trainings[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class TrainingDetailsScreen extends StatelessWidget {
  final String trainingTitle;

  TrainingDetailsScreen({required this.trainingTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trainingTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'Detalhes sobre $trainingTitle',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
