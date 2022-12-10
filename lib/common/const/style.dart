import 'package:flutter/material.dart';

const double DEFAULT_PADDING = 20;
const double DEFAULT_HIGHT_PADDING = 10;
const double DEFAULT_WIDTH_PADDING = 10;
const double DEFAULT_RADIUS =20.0;
// Color

const gray010 = Color(0xffF7F7F8);
const gray020 = Color(0xffE3E3E8);
const gray030 = Color(0xff9090A2);
const whiteColor = Colors.white;



//Button style
final EleButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
    ));
