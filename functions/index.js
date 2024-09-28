// Carregar variáveis de ambiente do arquivo .env
require('dotenv').config();

const functions = require('firebase-functions');
const nodemailer = require('nodemailer');
const admin = require('firebase-admin');
const cors = require('cors')({ origin: true });

// Inicializar Firebase Admin SDK
admin.initializeApp();

// Configuração do Nodemailer para SendGrid usando variável de ambiente
const transporter = nodemailer.createTransport({
  service: 'SendGrid',
  auth: {
    user: 'apikey',
    pass: process.env.SENDGRID_API_KEY, // Use a variável de ambiente
  },
});

// Função para verificar se o usuário está registrado e enviar o email
exports.sendVerificationEmail = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    const { email, code } = req.body;

    try {
      // Verificar se o usuário está registrado no Firebase Authentication
      const userRecord = await admin.auth().getUserByEmail(email);

      if (!userRecord) {
        return res.status(404).send('Usuário não encontrado no Firebase Authentication.');
      }

      // Se o usuário existe, enviar o email de verificação
      const mailOptions = {
        from: 'skillsync.fiap@gmail.com',
        to: email, // Email do destinatário (o usuário real)
        subject: 'Código de Verificação - Eurofarma Training',
        html: `
          <html>
            <body>
              <h2>Olá, ${userRecord.displayName || 'usuário'}!</h2>
              <p>Seu código de verificação é: <strong>${code}</strong></p>
              <p>Por favor, use este código para concluir o processo de login.</p>
              <p>Este código é válido por 10 minutos.</p>
            </body>
          </html>
        `,
      };

      // Enviar o email
      await transporter.sendMail(mailOptions);
      return res.status(200).send(`Código enviado para ${email}`);
    } catch (error) {
      return res.status(500).send(`Erro ao enviar email: ${error.message}`);
    }
  });
});
