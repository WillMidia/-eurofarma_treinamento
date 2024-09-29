import 'package:flutter/material.dart';
import '../services/training_service.dart';

class AddTrainingScreen extends StatefulWidget {
  @override
  _AddTrainingScreenState createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedCargo;

  final List<String> cargos = ['Farmacêutico', 'Assistente Administrativo', 'Técnico de Laboratório'];

  void _addTraining() async {
    if (_formKey.currentState!.validate()) {
      await TrainingService().addTrainingModule(
        _titleController.text,
        _descriptionController.text,
        selectedCargo!,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Treinamento adicionado com sucesso!')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Treinamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Por favor, insira um título' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) => value!.isEmpty ? 'Por favor, insira uma descrição' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedCargo,
                hint: Text('Selecione o Cargo'),
                onChanged: (value) {
                  setState(() {
                    selectedCargo = value;
                  });
                },
                items: cargos.map((cargo) {
                  return DropdownMenuItem<String>(
                    value: cargo,
                    child: Text(cargo),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Selecione um cargo' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addTraining,
                child: Text('Adicionar Treinamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
