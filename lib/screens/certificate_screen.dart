import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

class CertificateScreen extends StatelessWidget {
  final String userId;

  CertificateScreen({required this.userId});

  String _generateCertificateHtml(String nome, String curso, String instrutor) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(now);

    final String template = '''
    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Certificado de Conclusão</title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
        <style>
            @page {
                size: A4 landscape; /* Modo paisagem */
                margin: 0;
            }
            body {
                font-family: 'Montserrat', sans-serif; /* Fonte moderna e elaborada */
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .certificado {
                background-color: white;
                border: 10px solid #FFD700; /* Moldura amarela */
                border-radius: 15px; /* Bordas arredondadas */
                padding: 40px;
                width: 100%;
                max-width: 900px; /* Largura máxima para o certificado */
                text-align: center;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                position: relative;
                overflow: hidden; /* Para manter a moldura limpa */
            }
            .certificado::before, .certificado::after {
                content: '';
                position: absolute;
                top: 10px;
                left: 10px;
                right: 10px;
                bottom: 10px;
                border: 5px dashed #005eb8; /* Bordas azuis dentro da moldura */
                border-radius: 10px;
                z-index: -1; /* Colocar atrás do conteúdo */
            }
            h1 {
                color: #005eb8; /* Cor azul da Eurofarma */
                font-weight: 600; /* Peso da fonte para o título */
                font-size: 2.5em;
                text-transform: uppercase; /* Título em maiúsculas */
                letter-spacing: 2px; /* Espaçamento entre letras */
            }
            .subtitulo {
                font-size: 1.5em;
                margin: 20px 0;
                font-weight: 400;
            }
            .nome {
                font-size: 3em;
                font-weight: 600; /* Peso da fonte para o nome */
                margin: 20px 0;
                color: #333;
            }
            .curso {
                font-size: 2em;
                margin: 10px 0;
                font-style: italic; /* Estilo itálico para o curso */
            }
            .data {
                margin-top: 30px;
                font-size: 1.2em;
            }
            .assinatura {
                margin-top: 40px;
                font-size: 1em;
                font-style: italic;
                display: flex;
                justify-content: space-between; /* Para colocar as assinaturas lado a lado */
                padding: 0 20px; /* Espaçamento nas laterais */
            }
            .registro {
                font-size: 1em;
                margin-top: 10px;
                color: #555;
            }
        </style>
    </head>
    <body>

        <div class="certificado">
            <h1>Certificado de Conclusão</h1>
            <p class="subtitulo">Certificamos que</p>
            <p class="nome">$nome</p>
            <p class="curso">concluiu o curso de $curso</p>
            <p class="data">Data: $formattedDate</p>
            <div class="assinatura">
                <p>Assinatura: $instrutor</p>
            </div>
            <p class="congratulations">Parabéns pela sua conquista!</p>
            <p class="registro">Número de Registro: ${DateTime.now().millisecondsSinceEpoch}</p>
        </div>

    </body>
    </html>
    ''';

    return template;
  }

  Future<void> _createPdf(BuildContext context, String nome, String curso, String instrutor) async {
    final String htmlContent = _generateCertificateHtml(nome, curso, instrutor);

    // Gerar PDF e disponibilizar para download
    final blob = html.Blob([htmlContent], 'text/html');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'certificado_$nome.html')
      ..click();
    html.Url.revokeObjectUrl(url); // Libera o objeto URL
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final String nome = userData['nome'] ?? 'Nome do Aluno';
        final String curso = userData['cargo'] == 'Farmacêutico'
            ? 'Treinamento para Farmacêuticos'
            : userData['cargo'] == 'Assistente Administrativo'
            ? 'Treinamento para Assistente Administrativo'
            : 'Treinamento para Técnico de Laboratório';
        final String instrutor = 'Dr. EuroFarma';

        return Scaffold(
          appBar: AppBar(
            title: Text('Certificado'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () => _createPdf(context, nome, curso, instrutor),
              child: Text('Gerar Certificado'),
            ),
          ),
        );
      },
    );
  }
}
