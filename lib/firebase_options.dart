import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDIZPBpP62866NvDQG3T_NEgcsiOXg_kuw', // Chave de API da Web
    appId: '1:199401955195:web:7ecb456bbcb06f6ac2a7de', // Substitua pelo seu ID do aplicativo da Web
    messagingSenderId: '199401955195', // Sender ID
    projectId: 'eurofarma-training', // ID do projeto
    authDomain: 'eurofarma-training.firebaseapp.com', // Substitua pelo seu domínio de autenticação
    databaseURL: 'https://eurofarma-training-default-rtdb.firebaseio.com', // URL do banco de dados
    storageBucket: 'eurofarma-training.appspot.com', // Bucket de armazenamento
    measurementId: 'G-TMVPDD9NKQ', // ID de medição (se aplicável)
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIZPBpP62866NvDQG3T_NEgcsiOXg_kuw', // Chave de API do Android
    appId: '1:199401955195:android:26e7fe5edc8e3009c2a7de', // ID do aplicativo Android
    messagingSenderId: '199401955195', // Sender ID
    projectId: 'eurofarma-training', // ID do projeto
    databaseURL: 'https://eurofarma-training-default-rtdb.firebaseio.com', // URL do banco de dados
    storageBucket: 'eurofarma-training.appspot.com', // Bucket de armazenamento
  );
}
