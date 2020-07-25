import 'package:flutter/material.dart';

import 'gamepage.dart';

class WelcomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Flutter Memory Card Game!',
            style: TextStyle(fontSize: 30),
          ),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              color:Colors.amber,
              child: Text('New Game!',style: TextStyle(fontSize: 20),),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GamePage()),);
              },
            ),
          ),
        ],
      ),
    );
  }
}
