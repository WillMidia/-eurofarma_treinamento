import 'package:flutter/material.dart';

class CertificateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificado de Conclusão'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PARABÉNS!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Você completou todos os módulos do treinamento com sucesso!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Adicione a lógica para download ou visualização do certificado
                },
                child: Text('Baixar Certificado'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
