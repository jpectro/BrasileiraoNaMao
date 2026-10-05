import 'package:flutter/material.dart';

import '../repositories/brasileirao_repository.dart';
import '../theme/app_colors.dart';
import 'bolao_screen.dart';
import 'jogos_screen.dart';
import 'tabela_screen.dart';

class MainNavigator extends StatefulWidget {
  final BrasileiraoRepository repositorio;

  const MainNavigator({super.key, required this.repositorio});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  // IndexedStack mantém as abas vivas (não perde palpite ao trocar de aba)
  late final List<Widget> _screens = [
    JogosScreen(repositorio: widget.repositorio),
    TabelaScreen(repositorio: widget.repositorio),
    BolaoScreen(repositorio: widget.repositorio),
  ];

  @override
  Widget build(BuildContext context) {
    final online = widget.repositorio.online;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Brasileirão ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            Text(
              'Na Mão',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaria,
              ),
            ),
          ],
        ),
        actions: [
          Tooltip(
            message: online ? 'Conectado ao Firebase' : 'Usando dados de exemplo',
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                online ? Icons.cloud_done : Icons.cloud_off,
                color: online ? AppColors.primaria : AppColors.textoApagado,
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.primaria,
        unselectedItemColor: AppColors.textoSecundario,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
