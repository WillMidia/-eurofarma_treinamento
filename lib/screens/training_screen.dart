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
    {
      'title': 'Farmacocinética',
      'description': 'Estudo sobre como o corpo absorve, distribui, metaboliza e excreta medicamentos.',
      'icon': Icons.biotech
    },
    {
      'title': 'Toxicologia',
      'description': 'Análise dos efeitos adversos de substâncias químicas no organismo.',
      'icon': Icons.warning
    },
    {
      'title': 'Legislação Farmacêutica',
      'description': 'Aspectos legais e regulamentares da profissão farmacêutica.',
      'icon': Icons.gavel
    },
  ];

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
                width: 450, // Define a largura da imagem
                height: 450, // Define a altura da imagem
                child: Image.asset(
                  'assets/images/eurofarma-back.png', // Substitua pelo nome correto da imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir o container
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
                              ),
                            ),
                          );
                        },
                      );
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
                'A farmácia é uma ciência dedicada ao estudo dos medicamentos e à sua aplicação para a promoção da saúde. O curso de Introdução à Farmácia abrange uma variedade de tópicos essenciais que fornecem uma base sólida para o estudo mais aprofundado da profissão.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Conteúdo do Curso:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '• História da Farmácia\n'
                    '• Princípios da Farmacologia\n'
                    '• Ética e Legislação Farmacêutica\n'
                    '• Tipos de Medicamentos e Seus Usos\n'
                    '• Sistemas de Saúde e Papel do Farmacêutico\n',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 5),
              Image.asset(
                'assets/images/farmacia.jpg', // Atualize para o nome e caminho corretos da imagem
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Referências:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '• Livro: Introdução à Farmácia por Autor X\n'
                    '• Artigo: Fundamentos da Farmácia por Autor Y\n',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
            ],
            // Adicione outros conteúdos aqui para outros treinamentos se necessário
          ],
        ),
      ),
    );
  }
}
