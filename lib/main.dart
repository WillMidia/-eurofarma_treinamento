import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/training_screen.dart';
import 'screens/employee_login_screen.dart';
import 'screens/rh_login_screen.dart';
import 'screens/user_selection_screen.dart';
import 'screens/register_employee_screen.dart';
import 'screens/profile_registration_screen.dart';
import 'database/database_helper.dart'; // Importa o DatabaseHelper

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o banco de dados e adiciona dados de teste se necessário
  final dbHelper = DatabaseHelper();

  // Insira dados de teste no banco de dados, se necessário
  await dbHelper.insertTraining({
    'title': 'Introdução à Farmácia',
    'description': 'Um treinamento básico sobre farmacologia.',
    'icon': 'school',
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eurofarma Training',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => UserSelectionScreen(),
        '/employeeLogin': (context) => EmployeeLoginScreen(),
        '/rhLogin': (context) => RHLoginScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/training': (context) => TrainingScreen(),
        '/user_selection': (context) => UserSelectionScreen(),
        '/registerEmployee': (context) => RegisterEmployeeScreen(),
        '/profileRegistration': (context) => ProfileRegistrationScreen(),
      },
    );
  }
}
