import 'package:flutter/material.dart';

import '../models/info_time.dart';
import '../theme/app_colors.dart';

const Map<String, InfoTime> _times = {
  'Flamengo': InfoTime(sigla: 'FLA', cor: Color(0xFFE53935)),
  'Fluminense': InfoTime(sigla: 'FLU', cor: Color(0xFF7B1F3A)),
  'Palmeiras': InfoTime(sigla: 'PAL', cor: Color(0xFF1B5E20)),
  'São Paulo': InfoTime(sigla: 'SAO', cor: Colors.white, corTexto: Color(0xFFD32F2F)),
  'Atlético-MG': InfoTime(sigla: 'CAM', cor: Colors.black),
  'Cruzeiro': InfoTime(sigla: 'CRU', cor: Color(0xFF1565C0)),
  'Grêmio': InfoTime(sigla: 'GRE', cor: Color(0xFF0D7EC4)),
  'Internacional': InfoTime(sigla: 'INT', cor: Color(0xFFC62828)),
  'Bahia': InfoTime(sigla: 'BAH', cor: Color(0xFF1E3A8A)),
  'Vitória': InfoTime(sigla: 'VIT', cor: Color(0xFFB71C1C)),
  'Corinthians': InfoTime(sigla: 'COR', cor: Colors.white, corTexto: Colors.black),
  'Botafogo': InfoTime(sigla: 'BOT', cor: Colors.black),
  'Mirassol': InfoTime(sigla: 'MIR', cor: Color(0xFFFDD835), corTexto: Color(0xFF1B5E20)),
  'Santos': InfoTime(sigla: 'SAN', cor: Colors.white, corTexto: Colors.black),
  'Vasco': InfoTime(sigla: 'VAS', cor: Colors.black),
  'Bragantino': InfoTime(sigla: 'RBB', cor: Colors.white, corTexto: Color(0xFFC62828)),
  'Ceará': InfoTime(sigla: 'CEA', cor: Colors.black),
  'Fortaleza': InfoTime(sigla: 'FOR', cor: Color(0xFF0D47A1)),
  'Juventude': InfoTime(sigla: 'JUV', cor: Color(0xFF2E7D32)),
  'Sport': InfoTime(sigla: 'SPO', cor: Color(0xFFC62828)),
};

InfoTime infoDoTime(String nome) =>
    _times[nome] ??
    InfoTime(sigla: nome.substring(0, 3).toUpperCase(), cor: AppColors.card);
