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

  // Função para excluir colaborador com confirmação
  void _deleteUser(BuildContext context, String userId) async {
    // Mostra um diálogo de confirmação
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
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () async {
                try {
                  // Excluir o colaborador do Firestore
                  await _firestore.collection('users').doc(userId).delete();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Colaborador excluído com sucesso!')),
                  );
                  Navigator.of(context).pop(); // Fecha o diálogo
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
                          selectedTraining = null; // Limpar o treinamento ao trocar o cargo
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
                      // Atualizar os dados no Firestore
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

              return ListTile(
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
              );
            },
          );
        },
      ),
    );
  }
}
