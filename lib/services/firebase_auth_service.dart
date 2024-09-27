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

  // Método para enviar um código de verificação por email
  Future<void> sendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
      print("Email de verificação enviado para ${user.email}");
    } catch (e) {
      print("Erro ao enviar email de verificação: $e");
    }
  }

  // Verifica se o email do usuário logado é autorizado
  bool isAuthorizedUser(User? user) {
    const authorizedEmail = "usuario@exemplo.com"; // Substitua pelo email autorizado
    return user?.email == authorizedEmail;
  }

  // Método para deslogar
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
