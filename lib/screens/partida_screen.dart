import 'package:flutter/material.dart';

import '../models/estatistica.dart';
import '../models/evento_partida.dart';
import '../models/jogo.dart';
import '../theme/app_colors.dart';
import '../widgets/escudo.dart';
import '../widgets/estado_vazio.dart';

class PartidaScreen extends StatelessWidget {
  final Jogo jogo;

  const PartidaScreen({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('Rodada ${jogo.rodada}')),
        body: Column(
          children: [
            _Placar(jogo: jogo),
            const TabBar(
              indicatorColor: AppColors.primaria,
              labelColor: AppColors.primaria,
              unselectedLabelColor: AppColors.textoSecundario,
              dividerColor: AppColors.divisor,
              tabs: [
                Tab(text: 'Lances'),
                Tab(text: 'Estatísticas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _Lances(jogo: jogo),
                  _Estatisticas(jogo: jogo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CABEÇALHO ---

class _Placar extends StatelessWidget {
  final Jogo jogo;

  const _Placar({required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _TimeCabecalho(nome: jogo.timeCasa)),
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
                  Text(
                    jogo.comecou ? '${jogo.golsCasa} - ${jogo.golsFora}' : jogo.horario,
                    style: TextStyle(
                      fontSize: jogo.comecou ? 40 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(child: _TimeCabecalho(nome: jogo.timeFora)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.stadium, size: 16, color: AppColors.textoSecundario),
              const SizedBox(width: 6),
              Text(jogo.estadio, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeCabecalho extends StatelessWidget {
  final String nome;

  const _TimeCabecalho({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Escudo(time: nome, tamanho: 56),
        const SizedBox(height: 8),
        Text(
          nome,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

// --- LANCES ---

class _Lances extends StatelessWidget {
  final Jogo jogo;

  const _Lances({required this.jogo});

  @override
  Widget build(BuildContext context) {
    if (jogo.eventos.isEmpty) {
      return EstadoVazio(
        icone: Icons.schedule,
        mensagem: jogo.comecou ? 'Nenhum lance até agora' : 'A partida ainda não começou',
      );
    }

    // mais recente primeiro, como num app ao vivo
    final eventos = [...jogo.eventos]..sort((a, b) => b.minuto.compareTo(a.minuto));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: eventos.length,
      itemBuilder: (context, index) => _LinhaEvento(evento: eventos[index]),
    );
  }
}

class _LinhaEvento extends StatelessWidget {
  final EventoPartida evento;

  const _LinhaEvento({required this.evento});

  @override
  Widget build(BuildContext context) {
    final conteudo = _ConteudoEvento(evento: evento);

    // mandante na esquerda, visitante na direita
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: evento.doMandante ? conteudo : const SizedBox()),
          Container(
            width: 44,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${evento.minuto}'",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Expanded(child: evento.doMandante ? const SizedBox() : conteudo),
        ],
      ),
    );
  }
}

class _ConteudoEvento extends StatelessWidget {
  final EventoPartida evento;

  const _ConteudoEvento({required this.evento});

  @override
  Widget build(BuildContext context) {
    final direita = evento.doMandante;

    final textos = Flexible(
      child: Column(
        crossAxisAlignment: direita ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            evento.jogador,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: evento.ehGol ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          if (evento.detalhe != null)
            Text(
              evento.detalhe!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );

    final icone = _icone();
    const espaco = SizedBox(width: 8);

    return Row(
      mainAxisAlignment: direita ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: direita ? [textos, espaco, icone] : [icone, espaco, textos],
    );
  }

  Widget _icone() {
    return switch (evento.tipo) {
      TipoEvento.gol || TipoEvento.golPenalti =>
        const Icon(Icons.sports_soccer, color: AppColors.primaria, size: 20),
      TipoEvento.golContra => const Icon(Icons.sports_soccer, color: AppColors.perigo, size: 20),
      TipoEvento.cartaoAmarelo => const _Cartao(cor: AppColors.cartaoAmarelo),
      TipoEvento.cartaoVermelho => const _Cartao(cor: AppColors.perigo),
      TipoEvento.substituicao =>
        const Icon(Icons.swap_vert, color: AppColors.textoSecundario, size: 20),
    };
  }
}

class _Cartao extends StatelessWidget {
  final Color cor;

  const _Cartao({required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// --- ESTATÍSTICAS ---

class _Estatisticas extends StatelessWidget {
  final Jogo jogo;

  const _Estatisticas({required this.jogo});

  @override
  Widget build(BuildContext context) {
    final estatisticas = jogo.todasEstatisticas;

    if (estatisticas.isEmpty) {
      return const EstadoVazio(
        icone: Icons.bar_chart,
        mensagem: 'As estatísticas aparecem quando a partida começar',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: estatisticas.length,
      itemBuilder: (context, index) => _BarraEstatistica(estatistica: estatisticas[index]),
    );
  }
}

class _BarraEstatistica extends StatelessWidget {
  final Estatistica estatistica;

  const _BarraEstatistica({required this.estatistica});

  @override
  Widget build(BuildContext context) {
    final e = estatistica;
    // quem lidera fica em destaque
    final corCasa = e.casa >= e.fora ? AppColors.primaria : AppColors.textoApagado;
    final corFora = e.fora >= e.casa ? AppColors.primaria : AppColors.textoApagado;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(e.formatar(e.casa), style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(
                  e.nome,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Text(e.formatar(e.fora), style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _Barra(proporcao: e.proporcaoCasa, cor: corCasa, daDireita: true)),
              const SizedBox(width: 6),
              Expanded(child: _Barra(proporcao: e.proporcaoFora, cor: corFora, daDireita: false)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  final double proporcao;
  final Color cor;
  final bool daDireita;

  const _Barra({required this.proporcao, required this.cor, required this.daDireita});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      alignment: daDireita ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(3),
      ),
      child: FractionallySizedBox(
        widthFactor: proporcao,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
