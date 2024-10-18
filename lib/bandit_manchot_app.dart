import 'package:flutter/material.dart';
import 'bandit_manchot_home.dart'; // Import de l'interface utilisateur

class BanditManchotApp extends StatelessWidget {
  const BanditManchotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bandit Manchot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BanditManchotHomePage(title: 'Bandit Manchot'),
    );
  }
}
