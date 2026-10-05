import 'package:flutter/material.dart';

class InfoTime {
  final String sigla;
  final Color cor;
  final Color corTexto;

  const InfoTime({
    required this.sigla,
    required this.cor,
    this.corTexto = Colors.white,
  });
}
