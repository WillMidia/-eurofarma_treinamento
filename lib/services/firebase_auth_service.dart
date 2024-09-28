import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para login com email e senha
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erro ao fazer login: $e");
      return null;
    }
  }

  // Método para listar todos os usuários (Usando Firestore)
  Future<List<User?>> fetchAllUsers() async {
    // Aqui você vai precisar do Firestore para armazenar os usuários
    // Você pode usar Cloud Firestore ou um servidor backend para fazer isso
    return []; // Retorne a lista de usuários aqui
  }

  // Método para enviar um código de verificação por email
  Future<void> sendVerificationEmail(User user, String verificationCode) async {
    // Lógica para enviar o email com o código
    // Pode usar um serviço de envio de email como SendGrid ou Firebase Functions
    print("Email de verificação enviado para ${user.email} com o código $verificationCode");
  }

  // Método para deslogar
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Método para enviar email de redefinição de senha
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
