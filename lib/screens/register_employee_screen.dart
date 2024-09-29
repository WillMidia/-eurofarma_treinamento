import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_list_screen.dart'; // Importa a tela de listagem de colaboradores

class RegisterEmployeeScreen extends StatefulWidget {
  @override
  _RegisterEmployeeScreenState createState() => _RegisterEmployeeScreenState();
}

class _RegisterEmployeeScreenState extends State<RegisterEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? selectedCargo;
  String? selectedTraining;

  final List<String> cargos = ['Farmacêutico', 'Assistente Administrativo', 'Técnico de Laboratório'];
  final Map<String, List<String>> trainings = {
    'Farmacêutico': ['Curso de Farmácia', 'Treinamento de Química'],
    'Assistente Administrativo': ['Finanças', 'Gestão de Pessoas'],
    'Técnico de Laboratório': ['Operação de Equipamentos', 'Segurança Laboratorial'],
  };

  void _registerEmployee() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Criar usuário no Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Salvar informações do colaborador no Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'nome': _nameController.text,
          'cpf': _cpfController.text,
          'cargo': selectedCargo,
          'departamento': 'Farmacologia', // Certifique-se de passar o campo corretamente
          'training': selectedTraining,
          'email': _emailController.text,
        });

        // Mostrar sucesso e redirecionar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Colaborador registrado com sucesso!')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserListScreen()),
        );
      } catch (e) {
        print('Erro ao registrar colaborador: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Colaborador')),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 120,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 300,
                height: 280,
                child: Image.asset('assets/images/eurofarma-back.png'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Nome Completo',
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _cpfController,
                      hintText: 'CPF',
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedCargo,
                      hint: Text('Selecione o Cargo'),
                      onChanged: (value) {
                        setState(() {
                          selectedCargo = value;
                          selectedTraining = null; // Limpar treinamento ao trocar cargo
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
                    if (selectedCargo != null)
                      DropdownButtonFormField<String>(
                        value: selectedTraining,
                        hint: Text('Selecione o Treinamento'),
                        onChanged: (value) {
                          setState(() {
                            selectedTraining = value;
                          });
                        },
                        items: trainings[selectedCargo]!.map((training) {
                          return DropdownMenuItem<String>(
                            value: training,
                            child: Text(training),
                          );
                        }).toList(),
                        validator: (value) => value == null ? 'Selecione um treinamento' : null,
                      ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Senha',
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _registerEmployee,
                      child: Text('Registrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
