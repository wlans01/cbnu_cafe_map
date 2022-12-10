import 'package:flutter/material.dart';
import 'package:flutter_template/common/const/style.dart';
import 'package:flutter_template/common/layout/default_layout.dart';

import '../components/header.dart';
import '../components/search_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final int _itemCount = 10;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      padding: 0,
      body: SafeArea(
        child: DefaultTabController(
          length: _itemCount,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: DEFAULT_HIGHT_PADDING,
                      ),
                      const Header(),
                      const Padding(
                        padding: EdgeInsets.all(DEFAULT_PADDING),
                        child: SearchButton(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: DEFAULT_PADDING),
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor: Colors.black,
                          tabs: List.generate(
                            _itemCount,
                            (index) => Tab(text: 'Tab $index'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: DEFAULT_HIGHT_PADDING,
                      ),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: List.generate(
                _itemCount,
                    (index) => Container(color: Colors.red,),
              )
            ),
          ),
        ),
      ),
    );
  }
}
