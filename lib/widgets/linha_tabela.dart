import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

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
