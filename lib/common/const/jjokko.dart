import 'dart:math';

const jjokkoList = [
  'assets/images/jjokko1.jpg',
  'assets/images/jjokko2.jpg',
  'assets/images/jjokko3.jpg',
  'assets/images/jjokko4.jpg',
  'assets/images/jjokko5.jpg',
  'assets/images/jjokko6.jpg',
];


getJjokkoImage() {
  final Random random = Random();
  final String jjokko = jjokkoList[random.nextInt(jjokkoList.length)];
  return jjokko;
}