import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/user_selection_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/training_screen.dart';
import 'screens/employee_login_screen.dart';
import 'screens/rh_login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_employee_screen.dart';
import 'screens/profile_registration_screen.dart';
import 'screens/user_list_screen.dart';
import 'screens/certificate_screen.dart'; // Importando a tela de certificado

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Firebase inicializado com sucesso!");
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
        '/home': (context) => HomeScreen(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
        '/profile': (context) => ProfileScreen(),
        '/training': (context) => TrainingScreen(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
        '/registerEmployee': (context) => RegisterEmployeeScreen(),
        '/profileRegistration': (context) => ProfileRegistrationScreen(),
        '/userList': (context) => UserListScreen(),
        '/certificate': (context) => CertificateScreen(), // Adicionando a rota para a tela de certificado
      },
    );
  }
}
