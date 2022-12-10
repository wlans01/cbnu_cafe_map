import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/const/style.dart';
import '../../common/utils/get_size.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final _itemLength = 5;
  int currentPage = 500;
  int currentPageIndex = 1;
  final PageController _pageController =
  PageController(initialPage: 500, viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      currentPage++;

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenWidth(context) * 0.6,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index % _itemLength + 1;
              });
            },
            controller: _pageController,
            itemBuilder: (context, index) {
              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING / 2),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
                ),
                child: Center(
                  child: Text('image${index % _itemLength + 1}'),
                ),
              );
            },
          ),
          Positioned(
            top: 20,
            right: 80,
            child: Text('$currentPageIndex/$_itemLength'),
          )
        ],
      ),
    );
  }
}