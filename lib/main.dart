import 'package:flutter/material.dart';

import 'screens/main_navigator.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const BrasileiraoApp());
}

class BrasileiraoApp extends StatelessWidget {
  const BrasileiraoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brasileirão Na Mão',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.escuro,
      home: const MainNavigator(),
    );
  }
}
