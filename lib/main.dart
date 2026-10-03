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
            fontFamily: 'Inter',
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          surface: Color(0xFF1E1E1E),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Inter'),
          bodySmall: TextStyle(color: Color(0xFFB0B0B0), fontFamily: 'Inter'),
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
    final List jogosMockados = [
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
                    '\({jogo.golsCasa} -\){jogo.golsFora}',
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