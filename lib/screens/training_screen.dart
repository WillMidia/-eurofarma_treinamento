import 'package:flutter/material.dart';
import '../widgets/bottom_nav_screen.dart';
import '../database/database_helper.dart'; // Importa o helper do banco de dados
import '../models/training_model.dart'; // Importa o modelo de treinamento

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late Future<List<Training>> _trainings;

  @override
  void initState() {
    super.initState();
    _trainings = _fetchTrainings();
  }

  Future<List<Training>> _fetchTrainings() async {
    final dbHelper = DatabaseHelper();
    final List<Map<String, dynamic>> trainingMaps = await dbHelper.getTrainings();
    return List.generate(trainingMaps.length, (i) {
      return Training.fromMap(trainingMaps[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 450,
                height: 450,
                child: Image.asset(
                  'assets/images/eurofarma-back.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo à Área de Treinamentos',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<Training>>(
                    future: _trainings,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro ao carregar dados'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('Nenhum treinamento disponível'));
                      } else {
                        final trainings = snapshot.data!;
                        return ListView.builder(
                          itemCount: trainings.length,
                          itemBuilder: (context, index) {
                            final training = trainings[index];
                            return TrainingCard(
                              title: training.title,
                              description: training.description,
                              icon: Icons.school, // Ajuste conforme necessário
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrainingDetailsScreen(
                                      trainingTitle: training.title,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
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

  TrainingDetailsScreen({
    required this.trainingTitle,
  });

  @override
  Widget build(BuildContext context) {
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
            // Conteúdo detalhado para "Introdução à Farmácia"
            if (trainingTitle == 'Introdução à Farmácia') ...[
              SizedBox(height: 10),
              Text(
                'A farmácia é uma ciência dedicada ao estudo dos medicamentos e à sua aplicação para a promoção da saúde.',
                style: TextStyle(fontSize: 16),
              ),
              // Adicione mais conteúdo aqui
            ],
            // Adicione mais trechos de conteúdo para outras opções de treinamento
          ],
        ),
      ),
    );
  }
}
