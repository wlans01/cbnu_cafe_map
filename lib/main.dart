import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/screen/root_tab_screen.dart';
import 'package:flutter_template/product/screen/product_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'common/const/theme.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  GoRouter get _router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: RootTabScreen.routeName,
            builder: (context, state) => const RootTabScreen(),
            routes: [
              GoRoute(
                path: 'product_detail',
                name: ProductDetailScreen.routeName,
                builder: (context, state) => const ProductDetailScreen(),
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //상태바 투명
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    //세로모드 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp.router(
      theme: GAThemeData.lightTheme(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
    );
  }
}
