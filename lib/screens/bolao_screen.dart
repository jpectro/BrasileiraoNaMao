import 'package:flutter/material.dart';

import '../models/palpite.dart';
import '../repositories/brasileirao_repository.dart';
import '../theme/app_colors.dart';
import '../widgets/escudo.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/seletor_gols.dart';
import '../widgets/titulo_secao.dart';

class BolaoScreen extends StatefulWidget {
  final BrasileiraoRepository repositorio;

  const BolaoScreen({super.key, required this.repositorio});

  @override
  State<BolaoScreen> createState() => _BolaoScreenState();
}

class _BolaoScreenState extends State<BolaoScreen> {
  List<Palpite>? _palpites;
  bool _erro = false;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    try {
      final palpites = await widget.repositorio.palpites();
      if (mounted) setState(() => _palpites = palpites);
    } catch (_) {
      if (mounted) setState(() => _erro = true);
    }
  }

  Future<void> _salvar() async {
    setState(() => _salvando = true);
    String mensagem = 'Palpites salvos!';
    try {
      await widget.repositorio.salvarPalpites(_palpites!);
    } catch (_) {
      mensagem = 'Não foi possível salvar. Tente de novo.';
    }
    if (!mounted) return;
    setState(() => _salvando = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    if (_erro) {
      return const EstadoVazio(
        icone: Icons.wifi_off,
        mensagem: 'Não foi possível carregar o bolão',
      );
    }
    final palpites = _palpites;
    if (palpites == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
              itemCount: palpites.length,
              itemBuilder: (context, index) => _cardPalpite(palpites[index]),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _salvando ? null : _salvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaria,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _salvando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                    )
                  : const Text(
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
                  child: Column(
                    children: [
                      Escudo(time: palpite.timeCasa, tamanho: 28),
                      const SizedBox(height: 6),
                      Text(
                        palpite.timeCasa,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
                  child: Column(
                    children: [
                      Escudo(time: palpite.timeFora, tamanho: 28),
                      const SizedBox(height: 6),
                      Text(
                        palpite.timeFora,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
