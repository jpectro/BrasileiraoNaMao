import 'package:flutter/material.dart';

import '../data/times.dart';
import '../theme/app_colors.dart';

// Enquanto não temos os escudos oficiais, um círculo com a cor e a sigla do time
class Escudo extends StatelessWidget {
  final String time;
  final double tamanho;

  const Escudo({super.key, required this.time, this.tamanho = 40});

  @override
  Widget build(BuildContext context) {
    final info = infoDoTime(time);

    return Container(
      width: tamanho,
      height: tamanho,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: info.cor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.divisor),
      ),
      child: Text(
        info.sigla,
        style: TextStyle(
          color: info.corTexto,
          fontWeight: FontWeight.bold,
          fontSize: tamanho * 0.3,
        ),
      ),
    );
  }
}
