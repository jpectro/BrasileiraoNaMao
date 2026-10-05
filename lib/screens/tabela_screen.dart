import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/linha_tabela.dart';
import '../widgets/titulo_secao.dart';

class TabelaScreen extends StatelessWidget {
  const TabelaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classificacao = classificacaoMock;

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
