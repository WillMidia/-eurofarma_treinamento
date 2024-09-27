import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';
import '../services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmployeeLoginScreen extends StatefulWidget {
  @override
  _EmployeeLoginScreenState createState() => _EmployeeLoginScreenState();
}

class _EmployeeLoginScreenState extends State<EmployeeLoginScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController(); // Campo para código de verificação
  String? errorMessage;
  bool isVerifying = false; // Controla se estamos na fase de verificação

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _authService.signInWithEmailAndPassword(email, password);

    if (user != null) {
      if (_authService.isAuthorizedUser(user)) {
        if (!user.emailVerified) {
          await _authService.sendVerificationEmail(user);
          setState(() {
            isVerifying = true; // Muda para a fase de verificação
          });
        } else {
          // Se o usuário já está verificado, navega para a HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        setState(() {
          errorMessage = 'Acesso negado. Usuário não autorizado.';
        });
        _authService.signOut();
      }
    } else {
      setState(() {
        errorMessage = 'Falha no login. Verifique suas credenciais.';
      });
    }
  }

  void _verifyCode() {
    // Aqui você pode implementar a lógica para verificar o código que o usuário inseriu
    // Exemplo: comparar com um código gerado
    String code = _codeController.text;
    // Implementar a lógica de verificação aqui (você pode gerar um código aleatório e enviar por email)
    if (code == "123456") { // Exemplo de código fixo para teste
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        errorMessage = 'Código inválido. Tente novamente.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Image.asset(
                  'assets/images/eurofarma-back.png',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/eurofarma-logo.png',
                    width: 200,
                    height: 50,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Login de Funcionário',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Icon(
                  Icons.work,
                  size: 30,
                  color: Colors.blue,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'LOGIN',
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'SENHA',
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            if (errorMessage != null) ...[
                              SizedBox(height: 10),
                              Text(
                                errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                            if (isVerifying) ...[
                              CustomTextField(
                                controller: _codeController, // Campo para o código de verificação
                                hintText: 'CÓDIGO DE VERIFICAÇÃO',
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _verifyCode,
                                child: Text('VERIFICAR'),
                              ),
                            ],
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Lógica para recuperar senha pode ser adicionada aqui
                                },
                                child: Text(
                                  'Esqueci a senha',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: ElevatedButton(
                                      onPressed: _login,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                      ),
                                      child: Text(
                                        'ENTRAR',
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
