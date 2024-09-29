import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import necessário para usar Firestore

class AddTrainingModuleScreen extends StatefulWidget {
  @override
  _AddTrainingModuleScreenState createState() => _AddTrainingModuleScreenState();
}

class _AddTrainingModuleScreenState extends State<AddTrainingModuleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Módulo de Treinamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título do Módulo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Adiciona o módulo ao Firestore
                    await FirebaseFirestore.instance.collection('trainingModules').add({
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Módulo adicionado com sucesso!')));
                    Navigator.pop(context);
                  }
                },
                child: Text('Adicionar Módulo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
