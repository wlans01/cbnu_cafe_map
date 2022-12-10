import 'package:flutter/material.dart';

import '../const/style.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;
  final AppBar? appBar;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final double padding;
  final bool bodyBehind;

  const DefaultLayout({
    required this.body,
    this.backgroundColor,
    this.title,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.padding = DEFAULT_PADDING,
    this.bodyBehind = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: bodyBehind,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
      appBar: appBar ?? renderAppBar(),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title!),
        foregroundColor: Colors.black,
      );
    }
  }
}
