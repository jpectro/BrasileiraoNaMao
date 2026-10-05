import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class EstadoVazio extends StatelessWidget {
  final IconData icone;
  final String mensagem;

  const EstadoVazio({super.key, required this.icone, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 48, color: AppColors.textoApagado),
            const SizedBox(height: 12),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
