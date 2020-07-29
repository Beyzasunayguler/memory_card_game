import 'package:flutter/material.dart';
import 'package:memory_card_game/screens/welcomepagewidget.dart';

void main()=>runApp(MemoryGame());

class MemoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title='Memory Card';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.yellow[700],
        ),
        body: WelcomePageWidget(),
      ),
    );
  }
}




