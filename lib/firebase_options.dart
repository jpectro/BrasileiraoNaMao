import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// Dados copiados do console do Firebase (Configurações do projeto > Seus apps).
// Se algum app voltar pra PREENCHER, ele roda com os dados mockados.
class DefaultFirebaseOptions {
  static const _pendente = 'PREENCHER';

  static FirebaseOptions? get currentPlatform {
    if (kIsWeb) return _seConfigurado(web);
    if (defaultTargetPlatform == TargetPlatform.android) return _seConfigurado(android);
    return null; // Windows/Linux ficam nos mocks
  }

  static FirebaseOptions? _seConfigurado(FirebaseOptions opcoes) =>
      opcoes.apiKey == _pendente ? null : opcoes;

  static const web = FirebaseOptions(
    apiKey: 'AIzaSyCmPR1BsBpRq4KVvAB0BGPRxFOibm5p9T0',
    appId: '1:986800546551:web:bdd847ddb6e8d173a7e9f2',
    messagingSenderId: '986800546551',
    projectId: 'brasileirao-na-mao',
    authDomain: 'brasileirao-na-mao.firebaseapp.com',
    storageBucket: 'brasileirao-na-mao.firebasestorage.app',
  );

  static const android = FirebaseOptions(
    apiKey: 'AIzaSyCFn_odSBbJBGD9nNrPZ4_bxhh6Mm_UUJI',
    appId: '1:986800546551:android:1e7919c33d53f0f5a7e9f2',
    messagingSenderId: '986800546551',
    projectId: 'brasileirao-na-mao',
    storageBucket: 'brasileirao-na-mao.firebasestorage.app',
  );
}
