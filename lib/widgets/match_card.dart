import 'package:flutter/material.dart';

import '../models/jogo.dart';
import '../theme/app_colors.dart';
import 'escudo.dart';

class MatchCard extends StatelessWidget {
  final Jogo jogo;
  final VoidCallback? onTap;

  const MatchCard({super.key, required this.jogo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _Time(nome: jogo.timeCasa)),

              // Placar e tempo (ou horário, se ainda não começou)
              Column(
                children: [
                  Text(
                    jogo.comecou ? jogo.tempoJogo : 'Hoje',
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
                      jogo.comecou ? '${jogo.golsCasa} - ${jogo.golsFora}' : jogo.horario,
                      style: TextStyle(
                        fontSize: jogo.comecou ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(child: _Time(nome: jogo.timeFora)),
            ],
          ),
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
        Escudo(time: nome, tamanho: 36),
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
