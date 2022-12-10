import 'package:flutter/material.dart';

import '../const/style.dart';
import '../layout/default_layout.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor:  Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Ga_logo_name.png',
                fit: BoxFit.cover,
                color: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
