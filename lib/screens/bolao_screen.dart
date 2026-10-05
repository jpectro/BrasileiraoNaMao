import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/palpite.dart';
import '../theme/app_colors.dart';
import '../widgets/seletor_gols.dart';
import '../widgets/titulo_secao.dart';

class BolaoScreen extends StatefulWidget {
  const BolaoScreen({super.key});

  @override
  State<BolaoScreen> createState() => _BolaoScreenState();
}

class _BolaoScreenState extends State<BolaoScreen> {
  final List<Palpite> _palpites = criarPalpitesMock();

  void _salvar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Palpites salvos!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TituloSecao('Meus Palpites'),
          const SizedBox(height: 4),
          Text(
            'Próxima rodada',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _palpites.length,
              itemBuilder: (context, index) => _cardPalpite(_palpites[index]),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _salvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaria,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Salvar palpites',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPalpite(Palpite palpite) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(palpite.data, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    palpite.timeCasa,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SeletorGols(
                  gols: palpite.golsCasa,
                  onChanged: (v) => setState(() => palpite.golsCasa = v),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text('x'),
                ),
                SeletorGols(
                  gols: palpite.golsFora,
                  onChanged: (v) => setState(() => palpite.golsFora = v),
                ),
                Expanded(
                  child: Text(
                    palpite.timeFora,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
