import '../models/jogo.dart';
import '../models/palpite.dart';
import '../models/time_tabela.dart';

// Dados fake usados enquanto o Firebase não está ligado

final List<Jogo> jogosMock = [
  Jogo(timeCasa: 'Flamengo', timeFora: 'Fluminense', golsCasa: 2, golsFora: 1, tempoJogo: "75'", aoVivo: true),
  Jogo(timeCasa: 'Palmeiras', timeFora: 'São Paulo', golsCasa: 0, golsFora: 0, tempoJogo: "Intervalo", aoVivo: true),
  Jogo(timeCasa: 'Atlético-MG', timeFora: 'Cruzeiro', golsCasa: 3, golsFora: 1, tempoJogo: "Encerrado", aoVivo: false),
  Jogo(timeCasa: 'Grêmio', timeFora: 'Internacional', golsCasa: 1, golsFora: 1, tempoJogo: "12'", aoVivo: true),
  Jogo(timeCasa: 'Bahia', timeFora: 'Vitória', golsCasa: 0, golsFora: 2, tempoJogo: "Encerrado", aoVivo: false),
];

final List<TimeTabela> classificacaoMock = [
  TimeTabela(nome: 'Palmeiras', pontos: 62, jogos: 28, vitorias: 19, saldo: 29),
  TimeTabela(nome: 'Flamengo', pontos: 60, jogos: 28, vitorias: 18, saldo: 31),
  TimeTabela(nome: 'Cruzeiro', pontos: 54, jogos: 28, vitorias: 16, saldo: 18),
  TimeTabela(nome: 'Mirassol', pontos: 49, jogos: 28, vitorias: 13, saldo: 14),
  TimeTabela(nome: 'Bahia', pontos: 46, jogos: 28, vitorias: 13, saldo: 5),
  TimeTabela(nome: 'Botafogo', pontos: 45, jogos: 28, vitorias: 12, saldo: 10),
  TimeTabela(nome: 'Fluminense', pontos: 43, jogos: 28, vitorias: 13, saldo: 1),
  TimeTabela(nome: 'São Paulo', pontos: 40, jogos: 28, vitorias: 11, saldo: 0),
  TimeTabela(nome: 'Corinthians', pontos: 37, jogos: 28, vitorias: 10, saldo: -3),
  TimeTabela(nome: 'Internacional', pontos: 36, jogos: 28, vitorias: 9, saldo: -2),
  TimeTabela(nome: 'Grêmio', pontos: 35, jogos: 28, vitorias: 9, saldo: -5),
  TimeTabela(nome: 'Atlético-MG', pontos: 35, jogos: 28, vitorias: 9, saldo: -4),
  TimeTabela(nome: 'Vasco', pontos: 34, jogos: 28, vitorias: 10, saldo: 2),
  TimeTabela(nome: 'Santos', pontos: 32, jogos: 28, vitorias: 8, saldo: -8),
  TimeTabela(nome: 'Bragantino', pontos: 31, jogos: 28, vitorias: 9, saldo: -14),
  TimeTabela(nome: 'Vitória', pontos: 29, jogos: 28, vitorias: 7, saldo: -15),
  TimeTabela(nome: 'Ceará', pontos: 28, jogos: 28, vitorias: 7, saldo: -6),
  TimeTabela(nome: 'Fortaleza', pontos: 24, jogos: 28, vitorias: 6, saldo: -16),
  TimeTabela(nome: 'Juventude', pontos: 22, jogos: 28, vitorias: 6, saldo: -28),
  TimeTabela(nome: 'Sport', pontos: 17, jogos: 28, vitorias: 2, saldo: -21),
];

// Função porque o palpite é editável: cada tela recebe uma lista nova
List<Palpite> criarPalpitesMock() => [
      Palpite(timeCasa: 'Corinthians', timeFora: 'Palmeiras', data: 'Sáb, 16:00'),
      Palpite(timeCasa: 'Vasco', timeFora: 'Botafogo', data: 'Sáb, 18:30'),
      Palpite(timeCasa: 'Santos', timeFora: 'São Paulo', data: 'Dom, 16:00'),
      Palpite(timeCasa: 'Fortaleza', timeFora: 'Ceará', data: 'Dom, 18:30'),
    ];
