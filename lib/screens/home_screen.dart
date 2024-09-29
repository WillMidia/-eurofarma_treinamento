import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/bottom_nav_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BottomNavScreen(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 300,
                height: 300,
                child: Image.asset(
                  'assets/images/eurofarma-back.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 25),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/eurofarma-logo.png',
                  width: 200,
                  height: 50,
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text('Usuário não encontrado.'));
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
                  String nome = userData['nome'] ?? 'Nome não disponível';
                  String cargo = userData['cargo'] ?? 'Cargo não disponível';
                  String departamento = userData['departamento'] ?? 'Eurofarma';
                  String cpf = userData['cpf'] ?? 'CPF não disponível';

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(cargo, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                              SizedBox(height: 4),
                              Text(departamento, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                              SizedBox(height: 4),
                              Text(cpf, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/profile_picture.png'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Olá, eu sou o EuroBot! Seja bem-vindo ao app da Eurofarma!',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[700],
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: const Icon(
                          Icons.android,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
