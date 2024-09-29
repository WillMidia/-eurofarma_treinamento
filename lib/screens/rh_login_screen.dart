import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'rh_home_screen.dart'; // Importa a tela principal do RH
import 'package:cloud_firestore/cloud_firestore.dart'; // Para verificar o papel de RH

class RHLoginScreen extends StatefulWidget {
  @override
  _RHLoginScreenState createState() => _RHLoginScreenState();
}

class _RHLoginScreenState extends State<RHLoginScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController(); // Controller para o código de verificação
  String? errorMessage;
  bool isVerifying = false; // Controla se estamos na fase de verificação
  String verificationCode = '123456'; // Código de verificação predefinido para o RH

  // Função para enviar o email de verificação
  void _sendVerificationEmail(String email, String code) async {
    final url = 'https://us-central1-eurofarma-training.cloudfunctions.net/sendVerificationEmail'; // Substitua pelo seu projeto
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        print('Email enviado com sucesso!');
      } else {
        print('Falha ao enviar email: ${response.body}');
      }
    } catch (error) {
      print('Erro: $error');
    }
  }

  // Função de login
  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Verifica credenciais hardcoded para RH
    if (email == 'rh@empresa.com' && password == '123456') {
      // Simula o envio de código de verificação
      print('Código de verificação: $verificationCode');
      setState(() {
        isVerifying = true; // Ativa o modo de verificação
        errorMessage = null; // Limpa mensagem de erro
      });
      return; // Interrompe o fluxo para evitar autenticação no Firebase
    }

    // Login no Firebase
    User? user = await _authService.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // Verifica se o usuário tem o papel de RH
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists && userDoc.get('role') == 'RH') {
        // Simula o envio de código de verificação
        print('Código de verificação: $verificationCode');
        setState(() {
          isVerifying = true;
          errorMessage = null;
        });
      } else {
        setState(() {
          errorMessage = 'Acesso negado. Este usuário não é RH.';
        });
      }
    } else {
      setState(() {
        errorMessage = 'Falha no login. Verifique suas credenciais.';
      });
    }
  }

  // Função para verificar o código de verificação
  void _verifyCode() {
    String code = _codeController.text;
    if (code == verificationCode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RHHomeScreen()), // Redireciona para a tela de RH
      );
    } else {
      setState(() {
        errorMessage = 'Código inválido. Tente novamente.';
      });
    }
  }

  // Função para enviar email de redefinição de senha
  void _sendPasswordResetEmail() async {
    String email = _emailController.text;

    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, insira seu email.';
      });
      return;
    }

    try {
      await _authService.sendPasswordResetEmail(email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email Enviado'),
          content: Text('Verifique seu email para redefinir a senha.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      setState(() {
        errorMessage = 'Erro ao enviar email: ${error.toString()}';
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
                  'Login de RH',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Icon(
                  Icons.person,
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
                            AbsorbPointer( // Bloqueia a interação com os campos de texto se estiver verificando
                              absorbing: isVerifying,
                              child: Column(
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
                                ],
                              ),
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
                              SizedBox(height: 20),
                              CustomTextField(
                                controller: _codeController,
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
                                onPressed: _sendPasswordResetEmail, // Chama o método para enviar o email de redefinição de senha
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
                                      onPressed: isVerifying ? _verifyCode : _login,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                      ),
                                      child: Text(
                                        isVerifying ? 'VERIFICAR' : 'ENTRAR',
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
