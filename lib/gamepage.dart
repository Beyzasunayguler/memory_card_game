import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:memory_card_game/main.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Memory Card';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.yellow[700],
        ),
        body: MemoryGameMainPage(),
      ),
    );
  }
}

class MemoryGameMainPage extends StatefulWidget {
  @override
  _MemoryGameMainPageState createState() => _MemoryGameMainPageState();
}

class _MemoryGameMainPageState extends State<MemoryGameMainPage> {
  int _counter;
  Timer _timer;
  int _flippedCardCount = 0;
  List<GlobalKey<FlipCardState>> imagesStates;
  Map<int, String> answers = <int, String>{};
  List<String> listImages = [
    'images/lisa.png',
    'images/homer.png',
    'images/bart.png',
    'images/maggie.png',
    'images/marge.png',
    'images/milhouse.png',
    'images/lisa.png',
    'images/homer.png',
    'images/bart.png',
    'images/maggie.png',
    'images/marge.png',
    'images/milhouse.png',
  ];

  void initKeys() {
    imagesStates = <GlobalKey<FlipCardState>>[
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
    ];
  }

  @override
  void initState() {
    initKeys();
    _counter = 45;
    if (_timer != null) {
      _timer.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Game finished!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Try Again!',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GamePage()));
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Close',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MemoryGame()));
                        },
                      ),
                    ],
                  );
                });
          }
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(60),
          child: Text(
            'Kalan süreniz : $_counter',
            style: TextStyle(fontSize: 25),
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, index) {
              return FlipCard(
                key: imagesStates[index],
                flipOnTouch: false,
                onFlipDone: (value) {
                  if (!value && _flippedCardCount % 2 == 0) {
                    if (answers.length == listImages.length) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Game finished successfully!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'Play Again!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GamePage()),
                                      result: (_)=>false,
                                    );
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MemoryGame()));
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      int count = 0;
                      answers.forEach((ind, value) {
                        if (value == listImages[index]) {
                          count++;
                        }
                      });
                      if (count < 2) {
                        answers.clear();
                        imagesStates.forEach((key) {
                          if (key.currentState != null &&
                              !key.currentState.isFront) {
                            key.currentState.toggleCard();
                          }
                        });
                      }
                    }
                  }
                },
                direction: FlipDirection.VERTICAL,
                speed: 500,
                front: GestureDetector(
                  onTap: () {
                    _flippedCardCount++;
                    imagesStates[index].currentState.toggleCard();
                    answers[index] = listImages[index];
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      '?',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                back: GestureDetector(
                  onTap: () => imagesStates[index].currentState.toggleCard(),
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(listImages[index]),
                  ),
                ),
              );
            })
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
