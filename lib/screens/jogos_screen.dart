import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/jogo.dart';
import '../theme/app_colors.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/match_card.dart';
import '../widgets/titulo_secao.dart';
import 'partida_screen.dart';

enum _Filtro {
  todos('Todos'),
  aoVivo('Ao vivo'),
  encerrados('Encerrados'),
  proximos('Próximos');

  const _Filtro(this.label);
  final String label;

  bool aceita(Jogo jogo) => switch (this) {
        _Filtro.todos => true,
        _Filtro.aoVivo => jogo.aoVivo,
        _Filtro.encerrados => jogo.status == StatusJogo.encerrado,
        _Filtro.proximos => jogo.status == StatusJogo.agendado,
      };
}

class JogosScreen extends StatefulWidget {
  const JogosScreen({super.key});

  @override
  State<JogosScreen> createState() => _JogosScreenState();
}

class _JogosScreenState extends State<JogosScreen> {
  _Filtro _filtro = _Filtro.todos;

  void _abrirPartida(Jogo jogo) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PartidaScreen(jogo: jogo)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jogos = jogosMock.where(_filtro.aceita).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TituloSecao('Jogos de Hoje'),
          const SizedBox(height: 4),
          Text(
            'Brasileirão Série A · Rodada ${jogosMock.first.rodada}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final filtro in _Filtro.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filtro.label),
                      selected: filtro == _filtro,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _filtro = filtro),
                      selectedColor: AppColors.primaria,
                      backgroundColor: AppColors.card,
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                        color: filtro == _filtro ? Colors.black : AppColors.texto,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: jogos.isEmpty
                ? const EstadoVazio(
                    icone: Icons.sports_soccer,
                    mensagem: 'Nenhum jogo nessa categoria',
                  )
                : ListView.builder(
                    itemCount: jogos.length,
                    itemBuilder: (context, index) => MatchCard(
                      jogo: jogos[index],
                      onTap: () => _abrirPartida(jogos[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
