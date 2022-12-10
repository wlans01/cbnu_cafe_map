import 'package:flutter/material.dart';

class Ing extends StatelessWidget {
  static String get routeName => 'ing';
  const Ing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.amberAccent,
              backgroundImage: AssetImage('assets/ga.png'),
            ),
            Text('준비중인 컨텐츠',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 50),),
          ],
        ),
      ),
    );
  }
}
