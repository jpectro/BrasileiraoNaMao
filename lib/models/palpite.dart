class Palpite {
  final String id;
  final String timeCasa;
  final String timeFora;
  final String data;
  int golsCasa;
  int golsFora;

  Palpite({
    required this.id,
    required this.timeCasa,
    required this.timeFora,
    required this.data,
    this.golsCasa = 0,
    this.golsFora = 0,
  });

  factory Palpite.fromMap(String id, Map<String, dynamic> m) => Palpite(
        id: id,
        timeCasa: m['timeCasa'],
        timeFora: m['timeFora'],
        data: m['data'],
        golsCasa: (m['golsCasa'] as num?)?.toInt() ?? 0,
        golsFora: (m['golsFora'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'timeCasa': timeCasa,
        'timeFora': timeFora,
        'data': data,
        'golsCasa': golsCasa,
        'golsFora': golsFora,
      };
}
