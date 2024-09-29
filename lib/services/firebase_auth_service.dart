import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para registro de novo usuário
  Future<User?> registerUser(String email, String password, String nome, String cargo, String departamento, String cpf) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salvar informações do usuário no Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nome': nome,
        'email': email,
        'cargo': cargo,
        'departamento': departamento,
        'cpf': cpf,
      });

      print("Usuário registrado com sucesso! UID: ${userCredential.user!.uid}"); // Adicionando log
      return userCredential.user;
    } catch (e) {
      print("Erro ao registrar usuário: $e");
      return null;
    }
  }

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
  Future<void> sendVerificationEmail(User user, String verificationCode) async {
    // Lógica para enviar o email com o código
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

  // -------------------- Funções de Gerenciamento de Usuários --------------------

  // Método para registrar um novo usuário com email e senha
  Future<User?> createUserWithEmailAndPassword(String email, String password, Map<String, dynamic> additionalData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Após a criação, adicionamos dados extras no Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'status': 'active',
        ...additionalData,
      });

      return userCredential.user;
    } catch (e) {
      print("Erro ao criar usuário: $e");
      return null;
    }
  }

  // Método para atualizar dados do usuário no Firestore
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      print("Erro ao atualizar usuário: $e");
    }
  }

  // Método para desativar/inativar o usuário
  Future<void> deactivateUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'status': 'inactive',
      });
    } catch (e) {
      print("Erro ao desativar usuário: $e");
    }
  }

  // Método para excluir completamente um usuário
  Future<void> deleteUser(String uid) async {
    try {
      // Remover do Firebase Authentication
      await _auth.currentUser!.delete();

      // Remover do Firestore
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      print("Erro ao excluir usuário: $e");
    }
  }

  // Método para listar todos os usuários no Firestore
  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection('users').snapshots();
  }
}
