import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> cargos = ['Farmacêutico', 'Assistente Administrativo', 'Técnico de Laboratório'];
  final Map<String, List<String>> trainings = {
    'Farmacêutico': ['Curso de Farmácia', 'Treinamento de Química'],
    'Assistente Administrativo': ['Finanças', 'Gestão de Pessoas'],
    'Técnico de Laboratório': ['Operação de Equipamentos', 'Segurança Laboratorial'],
  };

  // Função para gerar um progresso mockado entre 0 e 100%
  double _generateMockProgress() {
    return (20 + (80 * (new DateTime.now().millisecondsSinceEpoch % 1000) / 1000));
  }

  // Função para excluir colaborador com confirmação
  void _deleteUser(BuildContext context, String userId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Você tem certeza que deseja excluir este colaborador?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () async {
                try {
                  await _firestore.collection('users').doc(userId).delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Colaborador excluído com sucesso!')),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao excluir colaborador: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Função para editar colaborador com dropdowns para cargo e treinamento
  void _editUser(BuildContext context, String userId, Map<String, dynamic> userData) {
    TextEditingController nameController = TextEditingController(text: userData['nome']);
    TextEditingController emailController = TextEditingController(text: userData['email']);
    TextEditingController cpfController = TextEditingController(text: userData['cpf']);

    String? selectedCargo = userData['cargo'];
    String? selectedTraining = userData['training'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Editar Colaborador'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: cpfController,
                      decoration: InputDecoration(labelText: 'CPF'),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCargo,
                      hint: Text('Selecione o Cargo'),
                      onChanged: (value) {
                        setState(() {
                          selectedCargo = value;
                          selectedTraining = null;
                        });
                      },
                      items: cargos.map((cargo) {
                        return DropdownMenuItem<String>(
                          value: cargo,
                          child: Text(cargo),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    if (selectedCargo != null)
                      DropdownButtonFormField<String>(
                        value: selectedTraining,
                        hint: Text('Selecione o Treinamento'),
                        onChanged: (value) {
                          setState(() {
                            selectedTraining = value;
                          });
                        },
                        items: trainings[selectedCargo!]!.map((training) {
                          return DropdownMenuItem<String>(
                            value: training,
                            child: Text(training),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    try {
                      await _firestore.collection('users').doc(userId).update({
                        'nome': nameController.text,
                        'email': emailController.text,
                        'cpf': cpfController.text,
                        'cargo': selectedCargo,
                        'training': selectedTraining,
                      });

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Colaborador atualizado com sucesso!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao atualizar colaborador: $e')),
                      );
                    }
                  },
                  child: Text('Salvar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Colaboradores'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar colaboradores.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum colaborador encontrado.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var userId = snapshot.data!.docs[index].id;
              double mockProgress = _generateMockProgress(); // Gera progresso mockado

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(userData['nome'] ?? 'Nome não disponível'),
                        subtitle: Text(userData['cargo'] ?? 'Cargo não disponível'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editUser(context, userId, userData);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteUser(context, userId);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Progresso no treinamento: ${(mockProgress).toStringAsFixed(0)}% em ${userData['training'] ?? 'Treinamento não disponível'}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      LinearProgressIndicator(
                        value: mockProgress / 100,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
