import 'package:flutter/material.dart';

import '../../common/const/style.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
        ),
        child: Row(
          children: const [
            Icon(
              Icons.search_rounded,
              color: Colors.grey,
            ),
            SizedBox(width: DEFAULT_PADDING),
            Text(
              '검색어를 입력해주세요',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
