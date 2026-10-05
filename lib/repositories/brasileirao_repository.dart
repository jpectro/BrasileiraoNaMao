import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../firebase_options.dart';
import '../models/jogo.dart';
import '../models/palpite.dart';
import '../models/time_tabela.dart';
import 'firestore_repository.dart';
import 'mock_repository.dart';

abstract class BrasileiraoRepository {
  // true quando os dados vêm do Firebase
  bool get online;

  Stream<List<Jogo>> jogos();
  Stream<List<TimeTabela>> classificacao();
  Future<List<Palpite>> palpites();
  Future<void> salvarPalpites(List<Palpite> palpites);

  // Tenta ligar o Firebase; se não der, segue com os mocks
  static Future<BrasileiraoRepository> iniciar() async {
    final opcoes = DefaultFirebaseOptions.currentPlatform;
    if (opcoes == null) return MockRepository();

    try {
      await Firebase.initializeApp(options: opcoes);
      final repo = FirestoreRepository(FirebaseFirestore.instance);
      await repo.popularSeVazio().timeout(const Duration(seconds: 10));
      return repo;
    } catch (e) {
      debugPrint('Firebase indisponível, usando mocks: $e');
      return MockRepository();
    }
  }
}
