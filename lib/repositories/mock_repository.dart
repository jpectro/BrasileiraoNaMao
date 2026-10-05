import '../data/mock_data.dart';
import '../models/jogo.dart';
import '../models/palpite.dart';
import '../models/time_tabela.dart';
import 'brasileirao_repository.dart';

class MockRepository implements BrasileiraoRepository {
  // palpites ficam só na memória enquanto o app está aberto
  final List<Palpite> _palpites = criarPalpitesMock();

  @override
  bool get online => false;

  @override
  Stream<List<Jogo>> jogos() => Stream.value(jogosMock);

  @override
  Stream<List<TimeTabela>> classificacao() => Stream.value(classificacaoMock);

  @override
  Future<List<Palpite>> palpites() async => _palpites;

  @override
  Future<void> salvarPalpites(List<Palpite> palpites) async {}
}
