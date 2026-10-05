import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'bolao_screen.dart';
import 'jogos_screen.dart';
import 'tabela_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    JogosScreen(),
    TabelaScreen(),
    BolaoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
      ),
      body: _screens[_currentIndex],
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
