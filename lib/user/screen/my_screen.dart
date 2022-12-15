import 'package:flutter/material.dart';
import 'package:flutter_template/common/layout/default_layout.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      body: Center(
        child: Text('내정보'),
      ),
    );
  }
}
