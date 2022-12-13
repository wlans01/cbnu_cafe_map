import 'package:flutter/material.dart';
import 'package:flutter_template/common/const/jjokko.dart';
import 'package:flutter_template/common/const/style.dart';
import 'package:flutter_template/product/screen/product_detail_screen.dart';
import 'package:go_router/go_router.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductsGroup(),
        ProductsGroup(),
        ProductsGroup(),
      ],
    );
  }
}

class ProductsGroup extends StatelessWidget {
  const ProductsGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ProductList',
                  style: Theme.of(context).textTheme.titleSmall),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text('더보기'),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.9),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCard(),
                  SizedBox(height: DEFAULT_PADDING),
                  ProductCard(),
                ],
              );
            },
          ),
        ),
        SizedBox(height: DEFAULT_PADDING),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailScreen()),
        );
      },
      child: SizedBox(
        width: 330,
        height: 120,
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
                child: Image.asset(
                  getJjokkoImage(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        ProductTag(tag: '큐티'),
                        SizedBox(width: 5),
                        ProductTag(tag: '섹시'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('귀여운 쪼고 사진'),
                    const SizedBox(height: 5),
                    Text(
                      '랜덤 사진',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '5,000',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Text('원')
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.bookmark_outline),
                            Text('0'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTag extends StatelessWidget {
  final String tag;

  const ProductTag({
    required this.tag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          tag,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
