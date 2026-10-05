import 'package:flutter/material.dart';

import '../models/jogo.dart';
import '../theme/app_colors.dart';

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
            Expanded(child: _Time(nome: jogo.timeCasa)),

            // Placar e tempo
            Column(
              children: [
                Text(
                  jogo.tempoJogo,
                  style: TextStyle(
                    color: jogo.aoVivo ? AppColors.primaria : AppColors.textoApagado,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.fundo,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${jogo.golsCasa} - ${jogo.golsFora}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ],
            ),

            Expanded(child: _Time(nome: jogo.timeFora)),
          ],
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final String nome;

  const _Time({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.shield, color: AppColors.textoApagado, size: 30),
        const SizedBox(height: 8),
        Text(
          nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
