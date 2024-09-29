import 'package:flutter/material.dart';
import 'register_employee_screen.dart';
import 'add_training_module_screen.dart';
import 'user_list_screen.dart';

class RHHomeScreen extends StatefulWidget {
  @override
  _RHHomeScreenState createState() => _RHHomeScreenState();
}

class _RHHomeScreenState extends State<RHHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(), // Tela inicial do RH (Dashboard)
    RegisterEmployeeScreen(), // Tela de cadastro de colaboradores
    AddTrainingModuleScreen(), // Tela de treinamento (Cadastro de Treinamentos/Módulos)
    UserListScreen(), // Tela de listagem de colaboradores
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Seção de perfil no topo
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile_picture.png'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'William Tedros', // Exemplo de nome
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gerente de Farmácia', // Exemplo de cargo
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Departamento: Farmacologia', // Exemplo de departamento
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'CPF: 123.456.789-00', // Exemplo de CPF
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16), // Espaço entre a seção de perfil e o conteúdo principal
          // Corpo da tela
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Cadastrar Colaborador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Cadastrar Treinamento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listar Colaboradores',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Cor do item selecionado
        unselectedItemColor: Colors.grey, // Define a cor dos itens não selecionados
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.pie_chart,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoCard(title: 'Total de Colaboradores', value: '150'),
                InfoCard(title: 'Novos Cadastros', value: '10'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Notificações Recentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            NotificationCard(
              title: 'Novo Cadastro',
              description: 'Novo colaborador foi cadastrado recentemente.',
              date: '12/08/2024',
            ),
            NotificationCard(
              title: 'Revisão de Documentos',
              description: 'Documentos de colaboradores precisam ser revisados.',
              date: '10/08/2024',
            ),
            NotificationCard(
              title: 'Atualização de Política',
              description: 'A política de RH foi atualizada. Confira as mudanças.',
              date: '08/08/2024',
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  NotificationCard({
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text(date, style: TextStyle(color: Colors.grey[600])),
      ),
    );
  }
}
