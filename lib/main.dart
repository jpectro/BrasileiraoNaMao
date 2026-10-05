import 'package:flutter/material.dart';

void main() {
  runApp(const BrasileiraoApp());
}

class BrasileiraoApp extends StatelessWidget {
  const BrasileiraoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brasileirão Na Mão',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00E676),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          surface: Color(0xFF1E1E1E),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Color(0xFFB0B0B0)),
        ),
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const JogosScreen(),
    const TabelaScreen(),
    const BolaoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Brasileirão ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            Text(
              'Na Mão',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFF00E676),
        unselectedItemColor: const Color(0xFFB0B0B0),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Jogos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Tabela',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score),
            label: 'Bolão',
          ),
        ],
      ),
    );
  }
}

// --- TELAS SEPARADAS ---

class Jogo {
  final String timeCasa;
  final String timeFora;
  final int golsCasa;
  final int golsFora;
  final String tempoJogo;
  final bool aoVivo;

  Jogo({
    required this.timeCasa,
    required this.timeFora,
    required this.golsCasa,
    required this.golsFora,
    required this.tempoJogo,
    required this.aoVivo,
  });
}

class JogosScreen extends StatelessWidget {
  const JogosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Jogo> jogosMockados = [
      Jogo(timeCasa: 'Flamengo', timeFora: 'Fluminense', golsCasa: 2, golsFora: 1, tempoJogo: "75'", aoVivo: true),
      Jogo(timeCasa: 'Palmeiras', timeFora: 'São Paulo', golsCasa: 0, golsFora: 0, tempoJogo: "Intervalo", aoVivo: true),
      Jogo(timeCasa: 'Atlético-MG', timeFora: 'Cruzeiro', golsCasa: 3, golsFora: 1, tempoJogo: "Encerrado", aoVivo: false),
      Jogo(timeCasa: 'Grêmio', timeFora: 'Internacional', golsCasa: 1, golsFora: 1, tempoJogo: "12'", aoVivo: true),
      Jogo(timeCasa: 'Bahia', timeFora: 'Vitória', golsCasa: 0, golsFora: 2, tempoJogo: "Encerrado", aoVivo: false),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jogos de Hoje',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: jogosMockados.length, 
              itemBuilder: (context, index) {
                return MatchCard(jogo: jogosMockados[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- COMPONENTES VISUAIS ---

class MatchCard extends StatelessWidget {
  final Jogo jogo;

  const MatchCard({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Time da Casa
            Expanded(
              child: Column(
                children: [
                  const Icon(Icons.shield, color: Colors.white54, size: 30),
                  const SizedBox(height: 8),
                  Text(
                    jogo.timeCasa, 
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Placar e Tempo
            Column(
              children: [
                Text(
                  jogo.tempoJogo,
                  style: TextStyle(
                    color: jogo.aoVivo ? const Color(0xFF00E676) : Colors.white54, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${jogo.golsCasa} - ${jogo.golsFora}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ],
            ),

            // Time Visitante
            Expanded(
              child: Column(
                children: [
                  const Icon(Icons.shield, color: Colors.white54, size: 30),
                  const SizedBox(height: 8),
                  Text(
                    jogo.timeFora, 
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TABELA ---

class TimeTabela {
  final String nome;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int saldo;

  TimeTabela({
    required this.nome,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.saldo,
  });
}

class TabelaScreen extends StatelessWidget {
  const TabelaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TimeTabela> classificacao = [
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Classificação',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const _LinhaTabela(
            posicao: '#',
            nome: 'Time',
            pontos: 'P',
            jogos: 'J',
            vitorias: 'V',
            saldo: 'SG',
            cabecalho: true,
          ),
          const Divider(color: Colors.white24),
          Expanded(
            child: ListView.builder(
              itemCount: classificacao.length,
              itemBuilder: (context, index) {
                final time = classificacao[index];
                return _LinhaTabela(
                  posicao: '${index + 1}',
                  nome: time.nome,
                  pontos: '${time.pontos}',
                  jogos: '${time.jogos}',
                  vitorias: '${time.vitorias}',
                  saldo: '${time.saldo}',
                  corZona: _corDaZona(index, classificacao.length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // G4 = Libertadores, Z4 = rebaixamento
  Color? _corDaZona(int index, int total) {
    if (index < 4) return const Color(0xFF00E676);
    if (index >= total - 4) return Colors.redAccent;
    return null;
  }
}

class _LinhaTabela extends StatelessWidget {
  final String posicao;
  final String nome;
  final String pontos;
  final String jogos;
  final String vitorias;
  final String saldo;
  final bool cabecalho;
  final Color? corZona;

  const _LinhaTabela({
    required this.posicao,
    required this.nome,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.saldo,
    this.cabecalho = false,
    this.corZona,
  });

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(
      fontWeight: cabecalho ? FontWeight.bold : FontWeight.normal,
      color: cabecalho ? Colors.white54 : Colors.white,
    );

    Widget coluna(String texto, {bool negrito = false}) {
      return SizedBox(
        width: 36,
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: negrito ? estilo.copyWith(fontWeight: FontWeight.bold) : estilo,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            color: corZona ?? Colors.transparent,
          ),
          coluna(posicao),
          Expanded(child: Text(nome, style: estilo)),
          coluna(pontos, negrito: true),
          coluna(jogos),
          coluna(vitorias),
          coluna(saldo),
        ],
      ),
    );
  }
}

// --- BOLÃO ---

class Palpite {
  final String timeCasa;
  final String timeFora;
  final String data;
  int golsCasa = 0;
  int golsFora = 0;

  Palpite({
    required this.timeCasa,
    required this.timeFora,
    required this.data,
  });
}

class BolaoScreen extends StatefulWidget {
  const BolaoScreen({super.key});

  @override
  State<BolaoScreen> createState() => _BolaoScreenState();
}

class _BolaoScreenState extends State<BolaoScreen> {
  final List<Palpite> _palpites = [
    Palpite(timeCasa: 'Corinthians', timeFora: 'Palmeiras', data: 'Sáb, 16:00'),
    Palpite(timeCasa: 'Vasco', timeFora: 'Botafogo', data: 'Sáb, 18:30'),
    Palpite(timeCasa: 'Santos', timeFora: 'São Paulo', data: 'Dom, 16:00'),
    Palpite(timeCasa: 'Fortaleza', timeFora: 'Ceará', data: 'Dom, 18:30'),
  ];

  void _salvar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Palpites salvos!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Meus Palpites',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Próxima rodada',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _palpites.length,
              itemBuilder: (context, index) {
                final palpite = _palpites[index];
                return Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(palpite.data, style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                palpite.timeCasa,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            _SeletorGols(
                              gols: palpite.golsCasa,
                              onChanged: (v) => setState(() => palpite.golsCasa = v),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text('x'),
                            ),
                            _SeletorGols(
                              gols: palpite.golsFora,
                              onChanged: (v) => setState(() => palpite.golsFora = v),
                            ),
                            Expanded(
                              child: Text(
                                palpite.timeFora,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _salvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Salvar palpites',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeletorGols extends StatelessWidget {
  final int gols;
  final ValueChanged<int> onChanged;

  const _SeletorGols({required this.gols, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onChanged(gols + 1),
          child: const Icon(Icons.keyboard_arrow_up, color: Color(0xFF00E676)),
        ),
        Container(
          width: 36,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$gols',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          // não deixa ficar negativo
          onTap: gols > 0 ? () => onChanged(gols - 1) : null,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: gols > 0 ? const Color(0xFF00E676) : Colors.white24,
          ),
        ),
      ],
    );
  }
}
