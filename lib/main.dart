import 'package:flutter/material.dart';

import 'repositories/brasileirao_repository.dart';
import 'repositories/mock_repository.dart';
import 'screens/main_navigator.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repositorio = await BrasileiraoRepository.iniciar();
  runApp(BrasileiraoApp(repositorio: repositorio));
}

class BrasileiraoApp extends StatelessWidget {
  final BrasileiraoRepository? repositorio;

  const BrasileiraoApp({super.key, this.repositorio});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brasileirão Na Mão',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.escuro,
      home: MainNavigator(repositorio: repositorio ?? MockRepository()),
    );
  }
}
