import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SeletorGols extends StatelessWidget {
  final int gols;
  final ValueChanged<int> onChanged;

  const SeletorGols({super.key, required this.gols, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onChanged(gols + 1),
          child: const Icon(Icons.keyboard_arrow_up, color: AppColors.primaria),
        ),
        Container(
          width: 36,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.fundo,
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
            color: gols > 0 ? AppColors.primaria : AppColors.divisor,
          ),
        ),
      ],
    );
  }
}
