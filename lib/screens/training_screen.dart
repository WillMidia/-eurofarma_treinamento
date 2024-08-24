import 'package:flutter/material.dart';
import '../widgets/bottom_nav_screen.dart'; // Certifique-se de importar o novo widget

class TrainingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> trainings = [
    {
      'title': 'Introdução à Farmácia',
      'description': 'Aprenda os fundamentos básicos da farmácia, incluindo ética e legislação.',
      'icon': Icons.school
    },
    {
      'title': 'Manipulação de Medicamentos',
      'description': 'Curso sobre a preparação e manipulação segura de medicamentos.',
      'icon': Icons.medication
    },
    {
      'title': 'Atendimento ao Cliente',
      'description': 'Técnicas para oferecer um atendimento de qualidade e resolver problemas comuns.',
      'icon': Icons.person
    },
    {
      'title': 'Gestão de Inventário',
      'description': 'Métodos eficazes para gerenciar e controlar o estoque de medicamentos.',
      'icon': Icons.inventory
    },
    {
      'title': 'Farmacologia Básica',
      'description': 'Conhecimentos fundamentais sobre farmacologia e como os medicamentos atuam.',
      'icon': Icons.local_pharmacy
    },
    {
      'title': 'Segurança e Compliance',
      'description': 'Práticas para garantir a segurança e conformidade nas operações farmacêuticas.',
      'icon': Icons.lock
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: trainings.length,
          itemBuilder: (context, index) {
            return TrainingCard(
              title: trainings[index]['title'],
              description: trainings[index]['description'],
              icon: trainings[index]['icon'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainingDetailsScreen(
                      trainingTitle: trainings[index]['title'],
                      trainingDescription: trainings[index]['description'],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TrainingCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  TrainingCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: Colors.blueAccent,
        ),
        contentPadding: EdgeInsets.all(16),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 14),
        ),
        onTap: onTap,
      ),
    );
  }
}

class TrainingDetailsScreen extends StatelessWidget {
  final String trainingTitle;
  final String trainingDescription;

  TrainingDetailsScreen({
    required this.trainingTitle,
    required this.trainingDescription,
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
              trainingDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conteúdo do Treinamento:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Introdução ao tópico\n• Metodologias e técnicas\n• Exemplos práticos\n• Avaliação e feedback',
              style: TextStyle(fontSize: 16),
            ),
            // Adicione mais detalhes do treinamento se necessário
          ],
        ),
      ),
    );
  }
}
