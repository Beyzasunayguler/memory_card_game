import 'package:flutter/material.dart';

//Colors
const boxColor= Colors.yellow;
const alertBackgroundColor=Colors.amber;
//Text Styles
const appButtonTextStyle= TextStyle(color: Colors.black,fontWeight: FontWeight.bold);
const alertTextStyle=TextStyle(fontWeight: FontWeight.bold);
const containerTextStyle= TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40);

//Decoration

const alertDialogShape=RoundedRectangleBorder(
  borderRadius:
  BorderRadius.all(Radius.circular(20)),
);

const containerDecoration= BoxDecoration(
  color: boxColor,
  shape: BoxShape.circle,
);