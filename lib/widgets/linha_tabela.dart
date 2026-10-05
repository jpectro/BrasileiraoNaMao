import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'escudo.dart';

class LinhaTabela extends StatelessWidget {
  final String posicao;
  final String nome;
  final String pontos;
  final String jogos;
  final String vitorias;
  final String saldo;
  final bool cabecalho;
  final Color? corZona;

  const LinhaTabela({
    super.key,
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
      color: cabecalho ? AppColors.textoApagado : AppColors.texto,
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
          // no cabeçalho só reserva o espaço do escudo
          if (cabecalho)
            const SizedBox(width: 30)
          else
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Escudo(time: nome, tamanho: 22),
            ),
          Expanded(child: Text(nome, style: estilo, overflow: TextOverflow.ellipsis)),
          coluna(pontos, negrito: true),
          coluna(jogos),
          coluna(vitorias),
          coluna(saldo),
        ],
      ),
    );
  }
}
