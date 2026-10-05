class Estatistica {
  final String nome;
  final int casa;
  final int fora;
  final bool percentual;

  const Estatistica({
    required this.nome,
    required this.casa,
    required this.fora,
    this.percentual = false,
  });

  bool get zerada => casa + fora == 0;

  double get proporcaoCasa => zerada ? 0 : casa / (casa + fora);
  double get proporcaoFora => zerada ? 0 : fora / (casa + fora);

  String formatar(int valor) => percentual ? '$valor%' : '$valor';
}
