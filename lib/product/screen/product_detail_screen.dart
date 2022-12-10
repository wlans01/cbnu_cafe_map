import 'package:flutter/material.dart';
import 'package:flutter_template/common/layout/default_layout.dart';
import 'package:flutter_template/common/utils/get_size.dart';

class ProductDetailScreen extends StatelessWidget {
  static String get routeName => 'product_detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        padding: 0,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('상품 상세'),
              centerTitle: true,
              pinned: true,
              expandedHeight:getScreenWidth(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) {
                  return Container(
                    height: 100,
                    color: Colors.accents[index % Colors.accents.length],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
