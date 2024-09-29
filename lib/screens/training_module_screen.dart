import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTrainingModuleScreen extends StatefulWidget {
  @override
  _AddTrainingModuleScreenState createState() => _AddTrainingModuleScreenState();
}

class _AddTrainingModuleScreenState extends State<AddTrainingModuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _trainingNameController = TextEditingController();
  final TextEditingController _moduleNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTrainingModule() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('training_modules').add({
          'training_name': _trainingNameController.text,
          'module_name': _moduleNameController.text,
          'description': _descriptionController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Módulo de Treinamento Adicionado com Sucesso!')));
        Navigator.pop(context);
      } catch (e) {
        print('Erro ao adicionar módulo de treinamento: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Módulo de Treinamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _trainingNameController,
                decoration: InputDecoration(labelText: 'Nome do Treinamento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do treinamento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _moduleNameController,
                decoration: InputDecoration(labelText: 'Nome do Módulo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do módulo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addTrainingModule,
                child: Text('Adicionar Módulo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
