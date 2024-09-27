import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Verifique se este arquivo está correto
import 'screens/user_selection_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/training_screen.dart';
import 'screens/employee_login_screen.dart';
import 'screens/rh_login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_employee_screen.dart'; // Adicionei o import da tela de cadastro de colaborador
import 'screens/profile_registration_screen.dart'; // Adicionei o import da tela de cadastro de perfil
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase inicializado com sucesso!"); // Mensagem de sucesso
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
