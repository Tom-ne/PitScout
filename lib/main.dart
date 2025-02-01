import 'package:flutter/material.dart';
import 'package:pitscout/theme/custom_theme.dart';
import 'package:pitscout/views/team_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pit Scout',
      theme: CustomTheme.theme,
      home: Scaffold(
        body: TeamCard(),
      ),
    );
  }
}
