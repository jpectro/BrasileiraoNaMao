import '../models/estatistica.dart';
import '../models/evento_partida.dart';
import '../models/jogo.dart';
import '../models/palpite.dart';
import '../models/time_tabela.dart';

// Dados fake usados enquanto o Firebase não está ligado

// Rodada 29: tem jogo ao vivo, no intervalo, encerrado e agendado
final List<Jogo> jogosMock = [
  Jogo(
    rodada: 29,
    timeCasa: 'Flamengo',
    timeFora: 'Fluminense',
    status: StatusJogo.aoVivo,
    minuto: 75,
    horario: '16:00',
    estadio: 'Maracanã',
    eventos: [
      _gol(9, true, 'Pedro', 'Arrascaeta'),
      _amarelo(23, false, 'Martinelli'),
      _gol(38, false, 'Germán Cano', 'Jhon Arias'),
      _sub(46, true, 'Bruno Henrique', 'Plata'),
      _penalti(61, true, 'Arrascaeta'),
      _amarelo(70, true, 'Pulgar'),
    ],
    estatisticas: _stats(posse: (58, 42), finalizacoes: (14, 8), noGol: (6, 3), escanteios: (6, 2), faltas: (9, 13), impedimentos: (1, 2)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Palmeiras',
    timeFora: 'São Paulo',
    status: StatusJogo.intervalo,
    horario: '16:00',
    estadio: 'Allianz Parque',
    eventos: [
      _amarelo(18, false, 'Alisson'),
      _amarelo(33, true, 'Aníbal Moreno'),
    ],
    estatisticas: _stats(posse: (61, 39), finalizacoes: (7, 3), noGol: (2, 1), escanteios: (4, 1), faltas: (6, 8), impedimentos: (0, 1)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Grêmio',
    timeFora: 'Internacional',
    status: StatusJogo.aoVivo,
    minuto: 12,
    horario: '18:30',
    estadio: 'Arena do Grêmio',
    eventos: [
      _golContra(4, true, 'Kannemann'),
      _gol(10, true, 'Braithwaite', 'Cristaldo'),
    ],
    estatisticas: _stats(posse: (55, 45), finalizacoes: (3, 2), noGol: (1, 0), escanteios: (1, 0), faltas: (2, 1), impedimentos: (0, 0)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Atlético-MG',
    timeFora: 'Cruzeiro',
    status: StatusJogo.encerrado,
    horario: '11:00',
    estadio: 'Arena MRV',
    eventos: [
      _gol(12, true, 'Hulk', 'Scarpa'),
      _gol(27, false, 'Kaio Jorge', 'Matheus Pereira'),
      _amarelo(44, false, 'Lucas Romero'),
      _gol(52, true, 'Rony'),
      _sub(63, false, 'Gabigol', 'Wanderson'),
      _vermelho(78, false, 'Fabrício Bruno'),
      _penalti(88, true, 'Hulk'),
    ],
    estatisticas: _stats(posse: (47, 53), finalizacoes: (16, 11), noGol: (8, 4), escanteios: (5, 7), faltas: (14, 12), impedimentos: (2, 1)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Bahia',
    timeFora: 'Vitória',
    status: StatusJogo.encerrado,
    horario: '11:00',
    estadio: 'Arena Fonte Nova',
    eventos: [
      _gol(31, false, 'Renato Kayzer'),
      _amarelo(55, true, 'Jean Lucas'),
      _sub(67, true, 'Willian José', 'Lucho Rodríguez'),
      _gol(84, false, 'Erick', 'Matheuzinho'),
    ],
    estatisticas: _stats(posse: (64, 36), finalizacoes: (15, 7), noGol: (4, 4), escanteios: (8, 2), faltas: (10, 15), impedimentos: (1, 3)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Vasco',
    timeFora: 'Bragantino',
    status: StatusJogo.encerrado,
    horario: '11:00',
    estadio: 'São Januário',
    eventos: [
      _gol(15, true, 'Vegetti', 'Coutinho'),
      _gol(40, false, 'Eduardo Sasha'),
      _penalti(58, false, 'Jhon Jhon'),
      _amarelo(66, true, 'Hugo Moura'),
      _gol(81, true, 'Philippe Coutinho', 'Nuno Moreira'),
    ],
    estatisticas: _stats(posse: (50, 50), finalizacoes: (12, 13), noGol: (5, 6), escanteios: (4, 5), faltas: (12, 11), impedimentos: (2, 2)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Juventude',
    timeFora: 'Sport',
    status: StatusJogo.encerrado,
    horario: '11:00',
    estadio: 'Alfredo Jaconi',
    eventos: [
      _gol(72, true, 'Gilberto'),
      _vermelho(89, false, 'Lucas Lima'),
    ],
    estatisticas: _stats(posse: (52, 48), finalizacoes: (10, 9), noGol: (3, 2), escanteios: (5, 4), faltas: (15, 17), impedimentos: (1, 0)),
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Mirassol',
    timeFora: 'Santos',
    status: StatusJogo.agendado,
    horario: '19:00',
    estadio: 'Maião',
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Corinthians',
    timeFora: 'Botafogo',
    status: StatusJogo.agendado,
    horario: '20:00',
    estadio: 'Neo Química Arena',
  ),
  Jogo(
    rodada: 29,
    timeCasa: 'Ceará',
    timeFora: 'Fortaleza',
    status: StatusJogo.agendado,
    horario: '21:30',
    estadio: 'Arena Castelão',
  ),
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
      Palpite(id: 'p1', timeCasa: 'Corinthians', timeFora: 'Palmeiras', data: 'Sáb, 16:00'),
      Palpite(id: 'p2', timeCasa: 'Vasco', timeFora: 'Botafogo', data: 'Sáb, 18:30'),
      Palpite(id: 'p3', timeCasa: 'Santos', timeFora: 'São Paulo', data: 'Dom, 16:00'),
      Palpite(id: 'p4', timeCasa: 'Fortaleza', timeFora: 'Ceará', data: 'Dom, 18:30'),
    ];

// Atalhos pra deixar os mocks legíveis

EventoPartida _gol(int minuto, bool mandante, String jogador, [String? assistencia]) => EventoPartida(
      minuto: minuto,
      tipo: TipoEvento.gol,
      jogador: jogador,
      doMandante: mandante,
      detalhe: assistencia == null ? null : 'Assist.: $assistencia',
    );

EventoPartida _penalti(int minuto, bool mandante, String jogador) => EventoPartida(
    minuto: minuto, tipo: TipoEvento.golPenalti, jogador: jogador, doMandante: mandante, detalhe: 'Pênalti');

EventoPartida _golContra(int minuto, bool mandante, String jogador) => EventoPartida(
    minuto: minuto, tipo: TipoEvento.golContra, jogador: jogador, doMandante: mandante, detalhe: 'Gol contra');

EventoPartida _amarelo(int minuto, bool mandante, String jogador) => EventoPartida(
    minuto: minuto, tipo: TipoEvento.cartaoAmarelo, jogador: jogador, doMandante: mandante);

EventoPartida _vermelho(int minuto, bool mandante, String jogador) => EventoPartida(
    minuto: minuto, tipo: TipoEvento.cartaoVermelho, jogador: jogador, doMandante: mandante);

EventoPartida _sub(int minuto, bool mandante, String entra, String sai) => EventoPartida(
    minuto: minuto, tipo: TipoEvento.substituicao, jogador: entra, doMandante: mandante, detalhe: 'Sai: $sai');

List<Estatistica> _stats({
  required (int, int) posse,
  required (int, int) finalizacoes,
  required (int, int) noGol,
  required (int, int) escanteios,
  required (int, int) faltas,
  required (int, int) impedimentos,
}) =>
    [
      Estatistica(nome: 'Posse de bola', casa: posse.$1, fora: posse.$2, percentual: true),
      Estatistica(nome: 'Finalizações', casa: finalizacoes.$1, fora: finalizacoes.$2),
      Estatistica(nome: 'Chutes no gol', casa: noGol.$1, fora: noGol.$2),
      Estatistica(nome: 'Escanteios', casa: escanteios.$1, fora: escanteios.$2),
      Estatistica(nome: 'Faltas', casa: faltas.$1, fora: faltas.$2),
      Estatistica(nome: 'Impedimentos', casa: impedimentos.$1, fora: impedimentos.$2),
    ];
