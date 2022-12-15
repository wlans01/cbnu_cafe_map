import 'package:flutter/material.dart';
import 'package:flutter_template/common/const/style.dart';
import 'package:flutter_template/common/layout/default_layout.dart';
import 'package:flutter_template/common/utils/get_size.dart';

import '../../common/const/jjokko.dart';

class ProductDetailScreen extends StatelessWidget {
  static String get routeName => 'product_detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      padding: 0,
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_outline),
                      ),
                    ],
                    elevation: 0,
                    pinned: true,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    expandedHeight: getScreenWidth(context) * 0.8 + 100,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SizedBox(
                        height: getScreenWidth(context),
                        width: getScreenWidth(context),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: getScreenWidth(context),
                                    color: Colors.red,
                                    child: Image.asset(
                                      getJjokkoImage(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 120,
                                width: getScreenWidth(context),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(DEFAULT_RADIUS),
                                    topRight: Radius.circular(DEFAULT_RADIUS),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    DEFAULT_HIGHT_PADDING,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                          getJjokkoImage(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: DEFAULT_WIDTH_PADDING,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '랜덤 쪼꼬 프로필',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                            Text(
                                              '쪼꼬 프로필',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              '귀여운 쪼꼬 보고가세요',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                   SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    primary: false,
                    pinned: true,
                    elevation: 0,
                    title: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      unselectedLabelColor: Colors.grey,
                      tabs:  [
                        Tab(
                          child: Text('상품정보'),
                        ),
                        Tab(
                          text: '상품후기',
                        ),
                        Tab(
                          text: '상품후기',
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      children: [
                        Container(
                          color: Colors.red,
                        ),
                        Container(
                          color: Colors.blue,
                        ),
                        Container(
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: DEFAULT_PADDING, vertical: DEFAULT_HIGHT_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: EleButtonStyle,
                  child: const Padding(
                    padding: EdgeInsets.all(DEFAULT_PADDING),
                    child: Text('구매하기'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
