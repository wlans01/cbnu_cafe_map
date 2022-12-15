import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ga_map/screen/googlemap_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../user/screen/my_screen.dart';
import '../layout/default_layout.dart';

class RootTabScreen extends StatefulWidget {
  static String get routeName => 'main';

  const RootTabScreen({Key? key}) : super(key: key);

  @override
  State<RootTabScreen> createState() => _RootTabScreenState();
}

class _RootTabScreenState extends State<RootTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? backButtOnPressedTime;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = _tabController.index;
    });
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    //Statement 1 Or statement2
    bool backButton = backButtOnPressedTime == null ||
        currentTime.difference(backButtOnPressedTime!) >
            const Duration(seconds: 3);

    if (backButton) {
      backButtOnPressedTime = currentTime;
      Fluttertoast.showToast(
        msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xff6E6E6E),
        fontSize: 15,
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await onWillPop();
      },
      child: DefaultLayout(
        padding: 0,
        body: [
          const GoogleMapScreen(),
          const HomeScreen(),
          const MyScreen(),
        ][index],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 14,
          unselectedFontSize: 14,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            _tabController.animateTo(index);
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: '내 정보',
            ),
          ],
        ),
      ),
    );
  }
}
