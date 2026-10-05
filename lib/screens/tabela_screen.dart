import 'package:flutter/material.dart';

import '../models/time_tabela.dart';
import '../repositories/brasileirao_repository.dart';
import '../theme/app_colors.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/linha_tabela.dart';
import '../widgets/titulo_secao.dart';

class TabelaScreen extends StatefulWidget {
  final BrasileiraoRepository repositorio;

  const TabelaScreen({super.key, required this.repositorio});

  @override
  State<TabelaScreen> createState() => _TabelaScreenState();
}

class _TabelaScreenState extends State<TabelaScreen> {
  late final Stream<List<TimeTabela>> _classificacao = widget.repositorio.classificacao();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TimeTabela>>(
      stream: _classificacao,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const EstadoVazio(
            icone: Icons.wifi_off,
            mensagem: 'Não foi possível carregar a tabela',
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return _conteudo(snapshot.data!);
      },
    );
  }

  Widget _conteudo(List<TimeTabela> classificacao) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TituloSecao('Classificação'),
          const SizedBox(height: 16),
          const LinhaTabela(
            posicao: '#',
            nome: 'Time',
            pontos: 'P',
            jogos: 'J',
            vitorias: 'V',
            saldo: 'SG',
            cabecalho: true,
          ),
          const Divider(color: AppColors.divisor),
          Expanded(
            child: ListView.builder(
              itemCount: classificacao.length,
              itemBuilder: (context, index) {
                final time = classificacao[index];
                return LinhaTabela(
                  posicao: '${index + 1}',
                  nome: time.nome,
                  pontos: '${time.pontos}',
                  jogos: '${time.jogos}',
                  vitorias: '${time.vitorias}',
                  saldo: '${time.saldo}',
                  corZona: _corDaZona(index, classificacao.length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // G4 = Libertadores, Z4 = rebaixamento
  Color? _corDaZona(int index, int total) {
    if (index < 4) return AppColors.primaria;
    if (index >= total - 4) return AppColors.perigo;
    return null;
  }
}
