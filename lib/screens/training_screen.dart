import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/training_data.dart';
import '../widgets/bottom_nav_screen.dart';
import 'training_detail_screen.dart';
import 'certificate_screen.dart'; // Importando a tela de certificado

class TrainingScreen extends StatefulWidget {
  final String userId;

  TrainingScreen({required this.userId});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  List<bool> moduleCompletionStatus = []; // Status de conclusão dos módulos
  double progress = 0; // Progresso total

  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Usuário não encontrado.'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String cargo = userData['cargo'] ?? 'Farmacêutico';
          final modules = trainingData[cargo] ?? [];

          // Inicializar o status de conclusão com base no número de módulos
          if (moduleCompletionStatus.length != modules.length) {
            moduleCompletionStatus = List.generate(modules.length, (index) => false);
          }

          // Calcular progresso
          progress = moduleCompletionStatus.where((completed) => completed).length / modules.length;

          return Stack(
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
                    LinearProgressIndicator(value: progress), // Barra de progresso
                    SizedBox(height: 10),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}% Concluído', // Porcentagem da barra
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Progresso do treinamento',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: modules.length,
                        itemBuilder: (context, index) {
                          return TrainingCard(
                            title: modules[index]['title'] ?? 'Título não disponível',
                            description: modules[index]['description'] ?? 'Descrição não disponível',
                            isCompleted: moduleCompletionStatus[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrainingDetailsScreen(
                                    trainingTitle: modules[index]['title'] ?? '',
                                    onComplete: () {
                                      setState(() {
                                        moduleCompletionStatus[index] = true; // Marcar como concluído
                                        if (moduleCompletionStatus.every((completed) => completed)) {
                                          // Se todos os módulos foram concluídos, mostre a mensagem
                                          showCompletionDialog(context);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ).then((_) {
                                // Retorna à lista de módulos após completar o último módulo
                                setState(() {});
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PARABÉNS!'),
          content: Text('Você concluiu todos os módulos do treinamento.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CertificateScreen()), // Navegar para a tela de certificado
                );
              },
              child: Text('Abrir Certificado'),
            ),
          ],
        );
      },
    );
  }
}

class TrainingCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted; // Status de conclusão
  final VoidCallback onTap;

  TrainingCard({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          Icons.school,
          size: 40,
          color: Colors.blueAccent,
        ),
        contentPadding: EdgeInsets.all(16),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            if (isCompleted) // Adiciona o "V" se o módulo estiver concluído
              Icon(Icons.check, color: Colors.green),
          ],
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
