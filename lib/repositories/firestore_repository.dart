import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/mock_data.dart';
import '../models/jogo.dart';
import '../models/palpite.dart';
import '../models/time_tabela.dart';
import 'brasileirao_repository.dart';

class FirestoreRepository implements BrasileiraoRepository {
  final FirebaseFirestore _db;

  FirestoreRepository(this._db);

  CollectionReference<Map<String, dynamic>> get _partidas => _db.collection('partidas');
  CollectionReference<Map<String, dynamic>> get _classificacao => _db.collection('classificacao');
  CollectionReference<Map<String, dynamic>> get _palpites => _db.collection('palpites');

  @override
  bool get online => true;

  // snapshots() = tempo real: mudou no console, muda no app
  @override
  Stream<List<Jogo>> jogos() => _partidas
      .orderBy('ordem')
      .snapshots()
      .map((s) => s.docs.map((d) => Jogo.fromMap(d.data())).toList());

  @override
  Stream<List<TimeTabela>> classificacao() => _classificacao
      .orderBy('posicao')
      .snapshots()
      .map((s) => s.docs.map((d) => TimeTabela.fromMap(d.data())).toList());

  @override
  Future<List<Palpite>> palpites() async {
    final s = await _palpites.orderBy('ordem').get();
    return s.docs.map((d) => Palpite.fromMap(d.id, d.data())).toList();
  }

  @override
  Future<void> salvarPalpites(List<Palpite> palpites) async {
    final batch = _db.batch();
    for (final p in palpites) {
      batch.update(_palpites.doc(p.id), {'golsCasa': p.golsCasa, 'golsFora': p.golsFora});
    }
    await batch.commit();
  }

  // Na primeira execução o banco está vazio: sobe os mocks pra lá
  Future<void> popularSeVazio() async {
    final existe = await _partidas.limit(1).get();
    if (existe.docs.isNotEmpty) return;

    final batch = _db.batch();

    for (final (i, jogo) in jogosMock.indexed) {
      batch.set(_partidas.doc('r${jogo.rodada}_${i + 1}'), {...jogo.toMap(), 'ordem': i});
    }
    for (final (i, time) in classificacaoMock.indexed) {
      batch.set(_classificacao.doc(time.nome), {...time.toMap(), 'posicao': i + 1});
    }
    for (final (i, palpite) in criarPalpitesMock().indexed) {
      batch.set(_palpites.doc(palpite.id), {...palpite.toMap(), 'ordem': i});
    }

    await batch.commit();
  }
}
