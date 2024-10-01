import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/bottom_nav_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = []; // Lista para armazenar as mensagens

  // Função que simula uma resposta do chatbot com base na pergunta
  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    String userMessage = _messageController.text;
    setState(() {
      messages.add({'sender': 'user', 'message': userMessage});
    });
    _messageController.clear();

    // Simular uma resposta do chatbot
    Future.delayed(Duration(seconds: 1), () {
      String botMessage = _getBotResponse(userMessage);
      setState(() {
        messages.add({'sender': 'bot', 'message': botMessage});
      });
    });
  }

  // Função para simular a resposta do bot com base na pergunta
  String _getBotResponse(String message) {
    message = message.toLowerCase();
    if (message.contains('treinamento')) {
      return 'Você pode acessar seus treinamentos na aba de Treinamentos!';
    } else if (message.contains('benefícios')) {
      return 'A Eurofarma oferece diversos benefícios, como plano de saúde, vale-alimentação e mais!';
    } else if (message.contains('contato')) {
      return 'Para mais informações, entre em contato com o RH da Eurofarma pelo email rh@eurofarma.com.br.';
    } else {
      return 'Desculpe, não entendi sua pergunta. Tente perguntar sobre "treinamentos", "benefícios" ou "contato".';
    }
  }

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
                stream: FirebaseFirestore.instance.collection('users').doc(widget.userId).snapshots(),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          bool isUser = messages[index]['sender'] == 'user';
                          return Align(
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isUser ? Colors.blueAccent : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                messages[index]['message']!,
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Digite sua mensagem...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send, color: Colors.blueAccent),
                            onPressed: _sendMessage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
