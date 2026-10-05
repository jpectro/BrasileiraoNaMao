import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../widgets/match_card.dart';
import '../widgets/titulo_secao.dart';

class JogosScreen extends StatelessWidget {
  const JogosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TituloSecao('Jogos de Hoje'),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: jogosMock.length,
              itemBuilder: (context, index) => MatchCard(jogo: jogosMock[index]),
            ),
          ),
        ],
      ),
    );
  }
}
